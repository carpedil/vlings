module main

import vweb
import os
import dba
import config { info }

const conf = config.new_test_config()

struct App {
	vweb.Context // pub mut:
}

fn main() {
	spawn start_socket_server()

	mut db := dba.create_db_connection() or { panic(err) }
	sql db {
		create table ApiData
		create table SrvData
	} or { panic('error on create table: ${err}') }

	db.close() or { panic(err) }

	mut app := &App{}
	app.serve_static('/favicon.ico', 'src/assets/favicon.ico')
	// makes all static files available.
	os.chdir(os.dir(os.executable()))!

	app.handle_static('_app', true)
	app.mount_static_folder_at(os.resource_abs_path('./templates'), '/')
	info('Running app on http://${conf.host_ip}:${conf.port}')
	vweb.run_at(app, vweb.RunParams{ host: conf.host_ip, port: conf.port, family: .ip }) or {
		panic(err)
	}
}

pub fn (mut app App) before_request() {
	info('[web] before_request: ${app.req.method} ${app.req.host} ${app.req.url} -> ${app.req.data}')
}

pub fn (mut app App) index() vweb.Result {
	return $vweb.html()
}

['/api/config']
pub fn (mut app App) config() vweb.Result {
	return app.json(conf.base_data)
}

['/test']
pub fn (mut app App) test() vweb.Result {
	return app.redirect('test.html')
}

['/api/test/hello']
pub fn (mut app App) hello() vweb.Result {
	return app.json('hello')
}
