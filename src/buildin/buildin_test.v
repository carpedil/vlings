module buildin


import os

fn test_index_after() {
	str := 'LOT_SRV,FANET,abc,XXXXXX,sdfs,sdfd'
	delimer :=',FANET,'
	starter:= str.split(delimer)[0]
	left_content := str.split(',FANET,')[1]
	left_content_body := left_content.split(',')[1]

	hostname := os.hostname()!
	println("${starter}${delimer}${hostname},${left_content_body}")
	println(str)
}

fn test_split() {
	str := 'CUSTOM_SRV,FANET,WIN10-OSF2,FTP_SRV,3.0.0.151,14 DATETIME=20230613093623'
	hostname := os.hostname()!
	mut str_split := str.split_nth(',',3)
	println(str_split)
	str_split[2] = hostname
	println(str_split.join(','))
}


struct User {
	name string
	age  int
}

fn test_print() {
	print(1)
	eprint('err...')
	println(2)
	println([1, 2, 3])
	eprintln('err again...')
	println(User{'jack', 18})
}

fn test_sizeof() {
	user := User{}

	println(sizeof(user))
	println(sizeof[User]())
	println(sizeof[int]())
	println(sizeof(1))
}

fn test_typeof() {
	println(typeof(User{'jack', 24}).name)
	println(typeof(10).name)
	println(typeof('hello').name)
	println(typeof(false).name)
}

fn test_isreftype() {
	println(isreftype[int]())
	println(isreftype[string]())
	println(isreftype[[]int]())
	println(isreftype[map[int]string]())
	println(isreftype('hello'))
	println(isreftype(10))
	user := User{'jack', 25}
	println(isreftype(user))
	println(isreftype[User]())
}

fn test_offsetof() {
	println(__offsetof(User, name))
	println(__offsetof(User, age))
}

fn factorial(n u32) u32 {
	if dump(n <= 1) {
		return dump(1)
	}
	return dump(n * factorial(n - 1))
}

fn test_dump() {
	println(factorial(5))
}
