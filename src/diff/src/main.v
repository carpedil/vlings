module main

import vweb
import databases
import os
import log

const (
	port        = 8082
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



	// spawn local_tcp_listener_setup(msg_chan, mut &loger)
	spawn start_server()

	mut db := databases.create_db_connection() or { panic(err) }

	sql db {
		create table ApiData
		create table SrvData
	} or { panic('error on create table: ${err}') }

	db.close() or { panic(err) }

	mut app := &App{}
	// app.serve_static('/favicon.ico', 'src/assets/favicon.ico')
	// makes all static files available.
	os.chdir(os.dir(os.executable()))!
	app.handle_static('_app', true)
	app.mount_static_folder_at(os.resource_abs_path('./templates'), '/')
	vweb.run_at(app, vweb.RunParams{ host: '10.8.3.125' port: 8082 family: .ip })or { panic(err) }
}

pub fn (mut app App) index() vweb.Result {
	return $vweb.html()
}

['/test']
pub fn (mut app App) test() vweb.Result {
	return app.redirect('test.html')
}

['/api/test/hello']
pub fn (mut app App) hello() vweb.Result {
	return app.json('hello')
}


