module main

import vweb
import json
import dba
import config { err, info }

['/api/srv/add'; post]
pub fn (mut app App) srv_save() !vweb.Result {
	mut db := dba.create_db_connection() or { panic(err) }
	defer {
		db.close() or { panic(err) }
	}
	data := json.decode(SrvData, app.req.data) or {
		err('Failed to decode json, error: ${err}')
		app.set_status(400, '')
		return app.text('Failed to decode json, error: ${err}')
	}
	info('decode SrvData from request ok\n ${data}')
	//  todo save data to db
	sd := SrvData{
		srv_name: data.srv_name
		default_hdr: data.default_hdr
	}
	mut insert_error := ''
	sql db {
		insert sd into SrvData
	} or { insert_error = err.msg() }
	if insert_error != '' {
		err('Failed to save srv data, error: ${err}')
		app.set_status(400, '')
		return app.json(insert_error)
	}
	info('save data to db ok \n${sd}')

	return app.json(data)
}

['/api/srv/list'; get]
pub fn (mut app App) srv_list() !vweb.Result {
	mut db := dba.create_db_connection() or { panic(err) }
	defer {
		db.close() or { panic(err) }
	}
	info('select from SrvData')
	results := sql db {
		select from SrvData
	}!

	info('results: ${results.len}')
	mut srv_list := []SrvDataDto{}
	for srv in results {
		mut srv_dto := SrvDataDto{}
		srv_dto.id = srv.id
		srv_dto.srv_name = srv.srv_name
		srv_dto.default_hdr = srv.default_hdr
		mut api_list := []ApiDataDto{}
		for api in srv.api_list {
			mut api_dto := ApiDataDto{
				id: api.id
				srv_id: api.srv_id
				api_name: api.api_name
				api_content: api.api_content
				api_param: json.decode([]Param, api.api_param)!
				is_inuse: api.is_inuse
			}
			// set default header for api hdr
			for mut param in api_dto.api_param {
				if param.key == 'HDR' {
					param.value = srv_dto.default_hdr
				}
			}
			api_list << api_dto
		}
		srv_dto.api_list = api_list

		info('${srv_dto.srv_name}')
		srv_list << srv_dto
	}
	return app.json(srv_list)
}
