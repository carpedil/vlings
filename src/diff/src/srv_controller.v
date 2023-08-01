module main

import vweb
import json
import databases

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
				is_inuse: api.is_inuse
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