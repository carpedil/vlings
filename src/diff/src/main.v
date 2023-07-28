module main

import vweb
import vweb.csrf
import databases
import os
import json

const (
	port        = 8082
	// the configuration moved here
	csrf_config = csrf.CsrfConfig{
		// change the secret
		// secret: 'my-64bytes-secret'
		// change to which domains you want to allow
		allowed_hosts: ['*']
	}
)

struct App {
	vweb.Context
// pub mut:
// 	middlewares map[string][]vweb.Middleware
}

pub fn (mut app App) before_request() {
	// csrf.protect(mut app.Context, csrf_config)
	println('[web] before_request: ${app.req.method} ${app.req.url} -> ${app.req.data}')
}

fn main() {
	mut db := databases.create_db_connection() or { panic(err) }

	sql db {
	} or { panic('error on create table: ${err}') }

	db.close() or { panic(err) }

	mut app := &App{
		// middlewares: {
		// 	'/': [csrf.middleware(csrf_config)]
		// }
	}
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

// ['/diff']
// pub fn (mut app App) diff() vweb.Result {
// 	return app.redirect('/diff.html')
// }

['/diff/hello']
pub fn (mut app App) hello() vweb.Result {
	return app.json('hello')
}

['/api/save'; post]
pub fn (mut api App) api_save() vweb.Result {
	data := json.decode(ApiData, api.req.data) or {
		api.set_status(400, '')
		return api.text('Failed to decode json, error: ${err}')
	}
	//  todo save data to db

	return api.json('data saved ${data}')
}

struct ApiData {
	server_name string // 服务名
	api_content string // Api格式化后的内容
	test_count  int    // 测试次数，不太准确，但可以作为排序算法的参数。 有利于SNI
}
