module interface

interface Speaker {
	speak(msg string) string
}

struct Dog {}

fn (d Dog) speak(msg string) string {
	return msg
}

struct Cat {}

fn (c Cat) speak(msg string) string {
	return msg
}
