module main

import term
import net
import net.websocket
import time


const (
	local_saddr = 'localhost:6020'
	local_paddr = '10.8.3.125:6020'
	ping_msg = r'GETLOTINFO HDR=QUERY_SRV,FANET,WIN10-OSF2,JOBIN,3.0.0.204,5 DATETIME=20230727114155 LOT=WQB05596.1 OPERATOR=OSFPQ02068'
)


fn slog(message string) {
	eprintln(term.colorize(term.bright_yellow, message))
}

fn clog(message string) {
	eprintln(term.colorize(term.cyan, message))
}

fn wlog(message string) {
	eprintln(term.colorize(term.bright_blue, message))
}

type Mc = fn (chan string) chan string

fn get_msg(ch chan string) string {
	mut message_box := []string{}
	select {
		message := <-ch {
			message_box << message
		}
	}
	return message_box.str()
}

// start_server starts the websocket server, it receives messages
// and send it back to the client that sent it
pub fn start_server() ! {
	mut s := websocket.new_server(.ip, 30000, '')
	defer {
		unsafe {
			s.free()
		}
	}

	// Make that in execution test time give time to execute at least one time
	s.set_ping_interval(500)
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
		mut msg_chan := chan string{cap: 2}
		
		slog('s.on_message msg.opcode: ${msg.opcode} | msg.payload: ${msg.payload.bytestr()}')
		addrs, message := parse_client_message(msg.payload.bytestr())
		spawn handle_connect_and_send(msg_chan,message,addrs)

		select {
			mc := <- msg_chan {
						ws.write(mc.bytes(), msg.opcode) or {
					clog('ws.write err: ${err}')
					return err
				}
			}
		}
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

fn handle_connect_and_send(msg_chan chan string,msg string, addrs []string) {
	spawn local_tcp_listener_setup(msg_chan)
	slog('Remote Tcp Server List : ${addrs}...')
	for addr in addrs {
		slog('try to connect Remote Tcp Server @${addr}...')
		mut conn := connect_to_server(addr) or { return }
		defer {
			conn.close() or { clog('Failed to close connection: ${err}') }
		}
		slog('connected server @${conn.addr()}')

		message := if msg == 'PING' { ping_msg } else { msg }

		ms := parse_message(message)
		slog('[Send Message]:${ms}')

		send_message(mut conn, ms)
		time.sleep(800 * time.millisecond)
	}
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



fn local_tcp_listener_setup(msg_chan chan string) {
	mut listener := net.listen_tcp(.ip, local_saddr) or { panic(err) }
	defer {
		listener.close() or { panic(err) }
	}
	slog('Tcp Listener Get Local Ip Address@${listener.addr()}')

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
		// push received message to message queue
		msg_chan <- received
		slog('[Received Message]:${received}')
	}
}