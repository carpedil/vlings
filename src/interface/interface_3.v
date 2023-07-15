module interface

interface Bar {
mut:
	write(string) string
}

struct MyBar {}

fn (mut mb MyBar) write(content string) string {
	println('writing content >> ${content}')
	return content
}
