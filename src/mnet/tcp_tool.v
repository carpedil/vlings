module main

import net
import time

const address = ':8080'

fn main() {
	mut conn := connect_to_server(address) or { return }

	message := 'Hello, server!'
	send_message(mut conn, message)

	// Add some delay to give the server time to process the request
	time.sleep(1 * time.second)

	response := receive_response(conn) or { return }

	println('Received response: ${response}')

	close_connection(mut conn)
}

fn connect_to_server(address string) !&net.TcpConn {
	return net.dial_tcp(address) or {
		println('Failed to connect to server: ${err}')
		return err
	}
}

fn send_message(mut conn net.TcpConn, message string) {
	conn.write_string(message) or { println('Failed to send message: ${err}') }
}

fn receive_response(conn &net.TcpConn) !string {
	mut buffer := [4096]u8{}
	mut total := 0
	for {
		len := conn.read(mut buffer[total..]) or {
			if total == 0 {
				println('Failed to receive response: ${err}')
			}
			return err
		}
		total += len
		if len == 0 {
			break
		}
	}
	return string(buffer[total].str())
}

fn close_connection(mut conn net.TcpConn) {
	conn.close() or { println('Failed to close connection: ${err}') }
}
