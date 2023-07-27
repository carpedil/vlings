module main

import net
import readline { read_line }
import log
import time

const addresss = ['10.162.138.83:6612', '10.9.64.28:6612']

const address_local = ['localhost:8090']

fn main() {
	mut l := log.Log{}
	l.set_level(.info)
	// Make a new file called info.log in the current folder
	l.set_full_logpath('./info.log')
	l.log_to_console_too()

	flag := read_line('local test only ? y|n')!
	addr := if flag.trim_space() == 'y' { address_local } else { addresss }

	if flag == 'y' {
		l.info("you'd better start the local tcp server first!")
	} else {
		l.info('start to connect the remote  tcp server')
	}
	spawn handle_connect_and_send(addr, mut &l)

	mut listener := net.listen_tcp(.ip, '10.8.3.125:6020') or { panic(err) }
	defer {
		listener.close() or { panic(err) }
	}
	l.info('Tcp Listener Get Local Ip Address@${listener.addr()}')

	for {
		mut conn := listener.accept() or { panic(err) }
		defer {
			conn.close() or {}
		}

		l.info('new connention coming from ${conn.peer_addr()}....')
		mut buf := []u8{len: 4096}
		nbytes := conn.read(mut buf) or {
			eprint(err)
			return
		}
		if nbytes == 0 {
			return
		}
		received := buf[0..nbytes].bytestr()
		l.info('[Received Message]:${received}')
	}
}

fn handle_connect_and_send(addrs []string, mut l log.Log) {
	l.info(' Remote Tcp Server List : ${addrs}...')
	for addr in addrs {
		l.info('try to connect Remote Tcp Server @${addr}...')
		mut conn := connect_to_server(addr, mut l) or { return }
		defer {
			conn.close() or { l.error('Failed to close connection: ${err}') }
		}
		l.info('connected server @${conn.addr()}')

		// GETLOTINFO HDR=QUERY_SRV,FANET,WIN10-OSF2,JOBIN,3.0.0.204,5 DATETIME=20230727114155 LOT=WQB05596.1 OPERATOR=OSFPQ02068
		message := r'CHGLOTCMT HDR=CLOT_SRV,FANET,WIN10-OSF2,CLOTCMT,3.0.0.151,130 DATETIME=20230613113534 OPERATOR=OSFPQ02068 LOT=WQB05215.1 CMT="new cc comment"'

		ms := parse_message(message)
		l.info('[Send Message]:${ms}')

		send_message(mut conn, ms, mut l)
		time.sleep(800 * time.millisecond)
	}
}

fn connect_to_server(address string, mut l log.Log) !&net.TcpConn {
	return net.dial_tcp(address) or {
		l.error('Failed to connect to server: ${err}')
		return err
	}
}

fn send_message(mut conn net.TcpConn, message string, mut l log.Log) {
	conn.write_string(message) or { l.error('Failed to send message: ${err}') }
}

fn parse_message(msg string) string {
	msg_len := msg.len
	msg_len_self := msg_len.str().len
	return '${msg_len_self}${msg_len}${msg}'
}
