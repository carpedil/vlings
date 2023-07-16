module jsons

import json

struct Foo {
	x int
}

struct User {
	name      string [required]
	age       int
	foo       Foo    [skip]
	last_name string [json: lastName]
}

fn test_decode_json() {
	data := '{"name":"rose","age":12,"lastName":"liya"}'
	user := json.decode(User, data) or {
		eprintln('fail to decode json ,err : ${err}')
		return
	}

	println(user.name)
	println(user.age)
	println(user.last_name)

	sfoos := '[{"x":100},{"x":10}]'
	foos := json.decode([]Foo, sfoos)!
	println(foos[0].x)
	println(foos[1].x)
}

fn test_encode_json() {
	mut data := map[string]int{}

	data['x'] = 142
	data['y'] = 124

	println(json.encode(data))

	user := &User{
		name: 'Jaock'
		age: 19
		last_name: 'Pitter'
	}
	println(json.encode(user))
}
