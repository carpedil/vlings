module main

import net
import readline { read_line }

const (
	server_addr1 = 'localhost'
	server_addr2 = 'localhost'
	server_port1 = '8081'
	server_port2 = '8082'
)

fn accept(mut server1 net.TcpListener, c1 chan &net.TcpConn, mut server2 net.TcpListener, c2 chan &net.TcpConn) {
	c1 <- server1.accept() or { panic(err) }
	c2 <- server2.accept() or { panic(err) }
}

fn setup() !(&net.TcpListener, &net.TcpConn, &net.TcpConn, &net.TcpListener, &net.TcpConn, &net.TcpConn) {
	srv1_addr := read_line_trim_space('enter server 1 addr')!
	server_addr_1 := if srv1_addr != '' { srv1_addr } else { server_addr1 }

	srv1_port := read_line_trim_space('enter server 1 port')!
	server_port_1 := if srv1_port != '' { srv1_port } else { server_port1 }
	println('listen tcp @${server_addr_1}:${server_port_1}...')
	mut srv1 := net.listen_tcp(.ip, '${server_addr_1}:${server_port_1}') or {
		println(err)
		exit(1)
	}

	srv2_addr := read_line_trim_space('enter server 2 addr')!
	server_addr_2 := if srv2_addr != '' { srv2_addr } else { server_addr2 }

	srv2_port := read_line_trim_space('enter server 2 port')!
	server_port_2 := if srv2_port != '' { srv2_port } else { server_port2 }
	println('listen tcp @${server_addr_2}:${server_port_2}...')
	mut srv2 := net.listen_tcp(.ip, '${server_addr_2}:${server_port_2}') or {
		println(err)
		exit(1)
	}
	println('please wait....')

	c1 := chan &net.TcpConn{}
	c2 := chan &net.TcpConn{}
	spawn accept(mut srv1, c1, mut srv2, c2)

	mut client1 := net.dial_tcp_with_bind('${server_addr_1}:${server_port_1}', 'localhost:6020') or {
		println(err)
		exit(1)
	}
	mut client2 := net.dial_tcp_with_bind('${server_addr_2}:${server_port_2}', 'localhost:6020') or {
		println(err)
		exit(1)
	}

	socket1 := <-c1
	socket2 := <-c2

	println('${srv1.addr()}-${client1.peer_addr()}, ${client1.addr()}-${socket1.peer_addr()}, ${socket1.addr()}')
	println('${srv2.addr()}-${client2.peer_addr()}, ${client2.addr()}-${socket2.peer_addr()}, ${socket2.addr()}')

	assert true
	return srv1, client1, socket1, srv2, client2, socket2
}

fn read_line_trim_space(prompt string) !string {
	input := read_line('${prompt}:')!
	return input.trim_space()
}

fn cleanup(mut server net.TcpListener, mut client net.TcpConn, mut socket net.TcpConn) {
	server.close() or {}
	client.close() or {}
	socket.close() or {}
}

fn main() {
	mut srv1, mut client1, mut socket1, mut srv2, mut client2, mut socket2 := setup()!
	defer {
		cleanup(mut srv1, mut client1, mut socket1)
		cleanup(mut srv2, mut client1, mut socket1)
	}
	message := r'EQPTYPELIST HDR=CQUERY_SRV,FANET,WIN10-OSF2,JOBIN,3.0.0.151,14 DATETIME=20230613093623'
	socket1.write_string(message) or {
		assert false
		return
	}
	socket2.write_string(message) or {
		assert false
		return
	}
	assert true

	mut buf1 := []u8{len: 1024}
	nbytes1 := client1.read(mut buf1) or {
		assert false
		return
	}
	received1 := buf1[0..nbytes1].bytestr()
	println('message received: ${received1}')

	mut buf2 := []u8{len: 1024}
	nbytes2 := client2.read(mut buf2) or {
		assert false
		return
	}
	received2 := buf2[0..nbytes2].bytestr()
	println('message received: ${received2}')

	assert received1 == received2
}
