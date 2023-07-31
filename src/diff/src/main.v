module main

import vweb
import databases
import os
import json

const (
	port = 8082
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

['/api/srv/add'; post]
pub fn (mut app App) srv_save() !vweb.Result {
	mut db := databases.create_db_connection() or { panic(err) }
	defer {
		db.close() or { panic(err) }
	}
	data := json.decode(SrvData, app.req.data) or {
		app.set_status(400, '')
		return app.text('Failed to decode json, error: ${err}')
	}
	//  todo save data to db
	sd := SrvData{
		srv_name: data.srv_name
	}
	mut insert_error := ''
	sql db {
		insert sd into SrvData
	} or { insert_error = err.msg() }
	if insert_error != '' {
		println(insert_error)
		app.set_status(400, '')
		return app.json(insert_error)
	}

	return app.json(data)
}

['/api/srv/list'; get]
pub fn (mut app App) srv_list() !vweb.Result {
	mut db := databases.create_db_connection() or { panic(err) }
	defer {
		db.close() or { panic(err) }
	}
	results := sql db {
		select from SrvData
	}!
	// println('===========================')
	// dump(results)
	// println('===========================')
	mut srv_list := []SrvDataDto{}
	for srv in results {
		mut srv_dto := SrvDataDto{}
		srv_dto.id = srv.id
		srv_dto.srv_name = srv.srv_name
		mut api_list := []ApiDataDto{}
		for api in srv.api_list {
			api_dto := ApiDataDto{
				id: api.id
				srv_id: api.srv_id
				api_name: api.api_name
				api_content: api.api_content
				api_param: json.decode([]Param, api.api_param)!
			}
			// dump(api_dto)
			api_list << api_dto
		}
		srv_dto.api_list = api_list
		dump(srv_dto)
		srv_list << srv_dto
	}

	return app.json(srv_list)
}

['/api/add'; post]
pub fn (mut app App) api_save() !vweb.Result {
	mut db := databases.create_db_connection() or { panic(err) }
	defer {
		db.close() or { panic(err) }
	}
	data := json.decode(ApiData, app.req.data) or {
		app.set_status(400, '')
		return app.text('Failed to decode json, error: ${err}')
	}

	// println('----------------------------')
	// dump(data)
	// println('----------------------------')

	//  todo save data to db
	ad := ApiData{
		srv_id: data.srv_id
		api_name: extract_api_name(data.api_content.trim_space())
		api_content: data.api_content
		api_param: extract_params(data.api_content.trim_space())
	}
	mut insert_error := ''
	sql db {
		insert ad into ApiData
	} or { insert_error = err.msg() }
	if insert_error != '' {
		println(insert_error)
		app.set_status(400, '')
		return app.json(insert_error)
	}

	api_dto := ApiDataDto{
		srv_id: ad.srv_id
		api_name: ad.api_name
		api_content: ad.api_content
		api_param: json.decode([]Param, ad.api_param)!
	}
	dump(api_dto)
	return app.json(api_dto)
}

//  " GETLOTINFO   HDR=  LOT=       OPERATOR= "
fn extract_api_name(contents string) string {
	return contents.split(' ')[0]
}

fn extract_params(contents string) string {
	content := contents.replace('  ', ' ')
	mut params := []Param{}
	println(content.split(' '))
	for splited_str in content.split(' ') {
		if splited_str.contains('=') {
			p := Param{
				key: splited_str.split('=')[0]
				value: ''
				is_required: false
			}
			params << p
		}
	}
	return json.encode(params)
}

[table: 'srv_data']
struct SrvData {
	id       int       [primary; sql: serial]
	srv_name string    [nonnull; sql_type: 'TEXT'; unique] // 服务名
	api_list []ApiData [fkey: 'srv_id']
}

[table: 'api_data']
struct ApiData {
	id          int    [primary; sql: serial]
	srv_id      int    [nonnull] // 服务名
	api_name    string [nonnull; sql_type: 'TEXT']
	api_content string [nonnull; sql_type: 'TEXT']
	api_param   string [nonnull; sql_type: 'TEXT']
	test_count  int    [default: '0'] // 测试次数，不太准确，但可以作为排序算法的参数。 有利于SNI
}

struct SrvDataDto {
mut:
	id       int
	srv_name string
	api_list []ApiDataDto
}

struct ApiDataDto {
mut:
	id          int
	srv_id      int
	api_name    string
	api_content string
	api_param   []Param
	test_count  int
}

struct Param {
	key         string
	value       string
	is_required bool
}
