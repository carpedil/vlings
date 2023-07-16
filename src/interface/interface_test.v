module interface

fn greet(s Speaker) {
	println(s.speak('Woof, woof !'))
}

fn test_speak() {
	dog := Dog{}
	greet(dog)
}

// ----------------------------------------------------------------------------------------------------------------
fn print_id(o IdOwner) {
	println('the id of user is : ${o.id}')
}

fn test_id_owner() {
	user := User{
		id: 1
	}
	print_id(user)
}

// ----------------------------------------------------------------------------------------------------------------

fn write(mut mb Bar) {
	println(mb.write('Bar'))
}

fn test_write_bar() {
	mut mb := MyBar{}

	write(mut mb)
}

// ----------------------------------------------------------------------------------------------------------------

fn greet2(s Speaker) {
	if s is Dog {
		println('a dog speaks: ${s.speak('Wong ,wong ~')}')
	} else if s is Cat {
		println('a cat speaks: ${s.speak('Meow ,meow ~')}')
	} else {
		println('something else')
	}
}

fn test_is_speaker() {
	c := Cat{}
	d := Dog{}
	greet2(c)
	greet2(d)
}

// ----------------------------------------------------------------------------------------------------------------

fn test_adopt() {
	fish := Fish{}
	println(fish.speak())

	a := Adoptable(fish)
	println(a.speak())

	if a is Fish {
		println(a.speak())
	}

	dog := Dog{}
	b := Adoptable(dog)
	println(b.speak())
}

// ----------------------------------------------------------------------------------------------------------------

fn test_embed_reader_writer() {
	mut m := MyReaderWriter{}
	mut content := 'hello'
	out := m.read(content)
	println(m.write(out))
}

// ----------------------------------------------------------------------------------------------------------------
