module sumtype

type Width = int | string

type JsonValue = []JsonValue | bool | f64 | int | map[string]JsonValue | string

struct Star {
	name string
}

struct Planet {
	name string
	age  int
}

type Object = Planet | Star

fn test_width() {
	int_width := Width(10)
	println(int_width)
	println(absolute_path(int_width))
	string_width := Width('calc(100% -100px)')
	println(string_width)
	println(absolute_path(string_width))

	planet := Object(Planet{
		name: 'Earth'
		age: 45
	})
	println(planet.name)
	// println(planet.age)
}

fn absolute_path(width Width) int {
	return match width {
		int { width }
		string { 0 }
	}
}

struct Empty {}

struct Node {
	value f64
	left  Tree
	right Tree
}

type Tree = Empty | Node

fn sum(tree Tree) f64 {
	return match tree {
		Empty { 0 }
		Node { tree.value + sum(tree.left) + sum(tree.right) }
	}
}

fn test_recursive() {
	left := Node{0.2, Empty{}, Empty{}}
	right := Node{0.3, Node{0.4, Empty{}, Empty{}}, Empty{}}

	tree := Node{0.5, left, right}
	println(sum(tree))
}

fn test_is_and_as() {
	width := Width(20)
	println(width is int)
	println(width is string)

	int_width := width as int
	println(int_width.hex2())
}

fn test_cast() {
	mut width := Width(20)
	if mut width is int {
		width = Width(35)
		println(width.hex2())
	}
}

struct Component {
	width Width
}

fn test_complex_exp() {
	component := Component{
		width: Width('calc(100% -100px)')
	}
	match component.width {
		int {
			println(component.width.hex2())
		}
		string {
			println(component.width.len)
		}
	}
}
