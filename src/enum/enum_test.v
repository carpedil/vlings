module enums

enum Color1 {
	@none
	red
	blue
	black
}

enum Color2 as u8 {
	red
	blue
	green
}

enum Color3 {
	red = 0xFF0000
	green = 0x00FF00
	blue = 0x0000FF
	gray = 0x000000
}

enum Color4 {
	any // value is 0
	red = 10
	green // value is 11
	blue // value is 12
	orange = 14
}

enum Cycle {
	one
	two
	three
}

fn (c Cycle) next() Cycle {
	match c {
		.one { return .two }
		.two { return .three }
		.three { return .one }
	}
}

fn test_next() {
	mut c := Cycle.one
	for _ in 0 .. 10 {
		println(c)
		c = c.next()
	}
}

fn test_color1() {
	mut color := Color1.red
	println(color)
	assert color.str() == 'red'
	assert int(Color1.blue) == 2
	color = .black
	println(color)
	color = Color1.@none
	println(color)
	match color {
		.red {
			println('the color is red, value:${int(color)}')
		}
		.blue {
			println('the color is blue, value:${int(color)}')
		}
		.black {
			println('the color is black, value:${int(color)}')
		}
		else {
			println('unknown')
		}
	}
}

fn test_color2() {
	c := Color2.green
	println('type: ${typeof(c).name}')
	assert int(c) == 2
}

fn test_color3() {
	println(Color3.gray)
	assert Color3.gray.str() == 'gray'
}

fn test_color4() {
	green := Color4.green
	orange := Color4.orange
	assert int(green) == int(orange) - 3
}
