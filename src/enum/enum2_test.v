module enums

[flag]
enum BitFiled {
	read
	write
	other
}

fn test_bitfiled() {
	println(BitFiled.read)
	println(BitFiled.write)
	println(BitFiled.other)
	mut flags := BitFiled.read
	flags.set(.write)
    println(flags.has(.read)) // true
    println(flags.has(.write)) // true
    println(flags.has(.other)) // false
    flags.clear(.write)
    println(flags.has(.write)) // false
	println(flags)
    flags.toggle(.other)
	println(flags)
    println(flags.has(.other)) // true
    println(flags.all(.write | .other)) // false
    println(flags.all(.read | .other | .write)) // false
}
