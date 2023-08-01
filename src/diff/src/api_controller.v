module main

import vweb
import json
import databases


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

