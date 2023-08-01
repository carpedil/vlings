module main

import vweb
import databases
import os
import net
import log


const (
	port = 8082
	local_saddr = 'localhost:6020'
	local_paddr = '10.8.3.125:6020'
)

struct App {
	vweb.Context // pub mut:
}

pub fn (mut app App) before_request() {
	println('[web] before_request: ${app.req.method} ${app.req.url} -> ${app.req.data}')
}


fn main() {
	mut loger := log.Log{}
	loger.set_level(.info)
	// Make a new file called info.log in the current folder
	loger.set_full_logpath('./info.log')
	loger.log_to_console_too()

	spawn local_tcp_listener_setup(mut &loger)

	mut db := databases.create_db_connection() or { panic(err) }

	sql db {
		create table ApiData
		create table SrvData
	} or { panic('error on create table: ${err}') }

	db.close() or { panic(err) }

	mut app := &App{}
	app.serve_static('/favicon.ico', 'src/assets/favicon.ico')
	// makes all static files available.
	os.chdir(os.dir(os.executable()))!
	app.handle_static('assets', true)
	app.mount_static_folder_at(os.resource_abs_path('.'), '/')
	vweb.run(app, port)
}

pub fn (mut app App) index() vweb.Result {
	return $vweb.html()
}

['/api/test/hello']
pub fn (mut app App) hello() vweb.Result {
	return app.json('hello')
}


fn local_tcp_listener_setup(mut loger log.Log) {
	mut listener := net.listen_tcp(.ip, local_saddr) or { panic(err) }
	defer {
		listener.close() or { panic(err) }
	}
	loger.info('Tcp Listener Get Local Ip Address@${listener.addr()}')

	for {
		mut conn := listener.accept() or { panic(err) }
		defer {
			conn.close() or {}
		}

		loger.info('new connention coming from ${conn.peer_addr()}....')
		mut buf := []u8{len: 4096}
		nbytes := conn.read(mut buf) or {
			eprint(err)
			return
		}
		if nbytes == 0 {
			return
		}
		received := buf[0..nbytes].bytestr()
		loger.info('[Received Message]:${received}')
	}
}