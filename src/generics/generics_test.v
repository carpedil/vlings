module generics

fn compare[T](a T, b T) int {
	if a < b {
		return -1
	}
	if a > b {
		return 1
	}
	return 0
}

fn test_compare() {
	println(compare[int](1, 2))
	println(compare[string]('a', 'b'))
	println(compare(4, 2))
	println(compare('hello', 'world'))
}

struct Optional[T] {
	value      T
	is_defined bool = true
}

struct Optional2[T] {
	value      T
	is_defined bool = true
}

fn (o Optional2[T]) map[U](f fn (T) U) Optional2[U] {
	if o.is_defined {
		return Optional2[U]{
			value: f(o.value)
		}
	}
	return Optional2[U]{
		is_defined: false
	}
}

fn (o Optional2[T]) or_else(default T) T {
	if o.is_defined {
		return o.value
	}
	return default
}

fn test_generics_struct() {
	op1 := Optional[int]{
		value: 10
	}
	op2 := Optional[string]{
		value: 'hello'
	}

	assert op1.value == 10

	assert op2.value.len == 5
}

fn test_map() {
	op := Optional2[string]{
		value: '100.5'
	}
	println(op.map(fn (str string) int {
		return str.int()
	})) // Optional2[int]{value: 100'}

	op2 := Optional2[string]{
		is_defined: false
	}
	println(op2.map(fn (str string) int {
		return str.int()
	})) // Optional2[int]{is_defined: false}
}

fn test_or_else() {
	op := Optional2[string]{
		is_defined: false
	}
	println(op.or_else('default'))

	op2 := Optional2[int]{
		value: 100
	}
	println(op2.or_else(200))
}

interface Iterator[T] {
	has_next() bool
mut:
	next() T
}

struct Array[T] {
mut:
	data []T
	pos  int
}

fn (arr Array[T]) has_next() bool {
	return arr.pos < arr.data.len
}

fn (mut arr Array[T]) next() T {
	pos := arr.pos
	arr.pos++
	return arr.data[pos]
}

fn each[T](mut it Iterator[T]) {
	for it.has_next() {
		println(it.next())
	}
}

fn test_each() {
	mut arr := Array[int]{
		data: [1, 2, 3]
	}
	each(mut arr)
}
