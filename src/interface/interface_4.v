module interface

interface Adoptable {}

fn (a Adoptable) speak() string {
	return 'adopt me !'
}

struct Fish {}

fn (f Fish) speak() string {
	return 'Shewo !'
}
