module buildin

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
