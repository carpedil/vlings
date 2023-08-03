module main

import term
import net
import net.websocket
import sync

fn slog(message string) {
	eprintln(term.colorize(term.bright_yellow, message))
}

fn clog(message string) {
	eprintln(term.colorize(term.cyan, message))
}

fn wlog(message string) {
	eprintln(term.colorize(term.bright_blue, message))
}


// start_server starts the websocket server, it receives messages
// and send it back to the client that sent it
pub fn start_server() ! {
	mut s := websocket.new_server(.ip, conf.socket_port, conf.socket_host)
	defer {
		unsafe {
			s.free()
		}
	}

	// Make that in execution test time give time to execute at least one time
	s.set_ping_interval(60*60*24)
	s.on_connect(fn (mut s websocket.ServerClient) !bool {
		slog('ws.on_connect, s.client_key: ${s.client_key}')
		// Here you can look att the client info and accept or not accept
		// just returning a true/false
		if s.resource_name != '/' {
			return false
		}
		return true
	})!
	s.on_message(fn (mut ws websocket.Client, msg &websocket.Message) ! {
		slog('s.on_message msg.opcode: ${msg.opcode} | msg.payload: ${msg.payload.bytestr()}')
		addrs, message := parse_client_message(msg.payload.bytestr())
		local_tcp_listener_setup(message, addrs, mut ws, msg)!
	})
	s.on_close(fn (mut ws websocket.Client, code int, reason string) ! {
		slog('s.on_close code: ${code}, reason: ${reason}')
		// println('client ($ws.id) closed connection')
	})
	s.listen() or {
		slog('s.listen err: ${err}')
		return err
	}
	slog('s.listen finished')
}

fn parse_client_message(payload string) ([]string, string) {
	slog('handle_client_message payload: ${payload}')
	addrs := payload.split('>')[0].split(',')
	msg := payload.split('>')[1]
	return addrs, msg
}

fn local_tcp_listener_setup(message string, addrs []string, mut ws websocket.Client, msg &websocket.Message) ! {
	mut listener := net.listen_tcp(.ip, conf.local_tcp_addr) or { panic(err) }
	defer {
		listener.close() or { panic(err) }
		slog('Tcp Listener closed')
	}
	slog('Tcp Listener Get Local Ip Address@${listener.addr()}')

	mut wg := sync.new_waitgroup()
	for addr in addrs {
		spawn handle_connect_and_send(mut wg, message, addr)
	}

	for {
		mut conn := listener.accept() or { panic(err) }
		defer {
			conn.close() or {}
		}

		slog('new connention coming from ${conn.peer_addr()}....')
		mut buf := []u8{len: 4096}
		nbytes := conn.read(mut buf) or {
			clog(err.msg())
			return
		}
		if nbytes == 0 {
			return
		}
		received := buf[0..nbytes].bytestr()
		slog('[${conn.peer_addr()!}][Received Message]:${received}')
		payload := '${conn.peer_ip()!}|${received}'
		ws.write(payload.bytes(), msg.opcode) or {
			clog('ws.write err: ${err}')
			return err
		}
	}
	wg.wait()
}

fn handle_connect_and_send(mut wg sync.WaitGroup, message string, addr string) ! {
	defer {
		wg.done()
	}
	wg.add(1)
	slog('try to connect Remote Tcp Server @${addr}')
	mut conn := connect_to_server('${addr}') or { return }
	defer {
		conn.close() or { clog('Failed to close connection: ${err}') }
	}
	slog('connected server @${conn.addr()}')

	ms := parse_message(message)
	slog('[${addr}][Send Message]:${ms}')

	send_message(mut conn, ms)
}

fn connect_to_server(address string) !&net.TcpConn {
	return net.dial_tcp(address) or {
		clog('Failed to connect to server: ${err}')
		return err
	}
}

fn send_message(mut conn net.TcpConn, message string) {
	conn.write_string(message) or { clog('Failed to send message: ${err}') }
}

fn parse_message(msg string) string {
	msg_len := msg.len
	msg_len_self := msg_len.str().len
	return '${msg_len_self}${msg_len}${msg}'
}
