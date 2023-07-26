module main

import net

fn main() {
	mut listener := net.listen_tcp(.ip, 'localhost:8090') or { panic(err) }
	defer {
		listener.close() or { panic(err) }
	}
	println('server start @${listener.addr()}')

	for {
		mut conn := listener.accept() or { panic(err) }
		spawn handle_conn(mut conn)
	}
}

fn handle_conn(mut conn net.TcpConn) ! {
	defer {
		conn.close() or {}
	}

	println('new connention coming from ${conn.peer_addr()}....')
	mut client := net.dial_tcp('10.8.3.125:6020') or { panic(err) }
	defer {
		client.close() or { println('Failed to close connection: ${err}') }
	}

	mut buf := []u8{len: 1024}
	nbytes := conn.read(mut buf) or { panic(err) }
	if nbytes == 0 {
		return
	}
	received := buf[0..nbytes].bytestr()
	println('received message from client:\n${received}')
	// ...handle request...

	client.write('HTTP/1.1 200 OK'.bytes()) or { panic(err) }
}
