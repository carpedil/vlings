module custom_print

struct Color {
	r int
	g int
	b int
}

fn (c Color) str() string {
	return '{${c.r},${c.g},${c.b}}'
}

fn (colors []Color) str() string {
	return colors.map(it.str()).join(';')
}

fn test_print_color() {
	c := Color{
		r: 255
		g: 0
		b: 0
	}
	println(c)

	cs := [
		Color{255, 0, 0},
		Color{0, 255, 0},
		Color{0, 255, 255},
	]
	println(cs)
}
