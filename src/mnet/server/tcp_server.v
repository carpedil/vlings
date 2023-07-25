module main

import net

fn main() {
	mut listener := net.listen_tcp(.ip, ':8080') or { panic(err) }
	println('server start @localhost:8080...')

	for {
		mut conn := listener.accept() or { panic(err) }

		spawn handle_conn(mut conn)
	}

	listener.close() or { panic(err) }
}

fn handle_conn(mut conn net.TcpConn) {
	defer {
		conn.close() or {}
	}

	for {
		println('connention ....')
		mut buf := []u8{len: 1024}
		nbytes := conn.read(mut buf) or { panic(err) }
		if nbytes == 0 {
			break
		}
		received := buf[0..nbytes].bytestr()
		// ...handle request...

		conn.write('HTTP/1.1 200 OK\r\n\r\n${received}'.bytes()) or { panic(err) }
	}
}
