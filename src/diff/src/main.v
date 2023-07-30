module main

import vweb
import databases
import os
import json

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
	mut db := databases.create_db_connection() or { panic(err) }

	sql db {
		create table ApiData
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


['/diff/hello']
pub fn (mut app App) hello() vweb.Result {
	return app.json('hello')
}

['/api/save'; post]
pub fn (mut app App) api_save() !vweb.Result {
	mut db := databases.create_db_connection() or { panic(err) }
	defer {
		db.close() or { panic(err) }
	}
	data := json.decode(ApiData, app.req.data) or {
		app.set_status(400, '')
		return app.text('Failed to decode json, error: ${err}')
	}
	//  todo save data to db
	ad := ApiData{
		srv_name: data.srv_name
		api_content: data.api_content
	}
	mut insert_error := ''
	sql db {
		insert ad into ApiData
	} or { insert_error = err.msg() }
	if insert_error != '' {
		println(insert_error)
		app.set_status(400, '')
		return app.text('${insert_error}')
	}

	return app.json('data saved ${data}')
}

[table: 'api_data']
struct ApiData {
	id          int    [primary; sql: serial]
	srv_name    string [nonnull; sql_type: 'TEXT'] // 服务名
	api_content string [nonnull; sql_type: 'TEXT'] // Api格式化后的内容
	test_count  int    [default: '0'] // 测试次数，不太准确，但可以作为排序算法的参数。 有利于SNI
}
