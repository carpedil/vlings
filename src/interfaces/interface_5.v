module interface

pub interface IReader {
mut:
	read(buf string) ?int
}

pub interface IWriter {
mut:
	write(buf string) ?int
}

interface ReaderWriter {
	IReader
	IWriter
}

struct MyReaderWriter {}

fn (mut m MyReaderWriter) read(buf string) string {
	println('reading from file...')
	return buf
}

fn (mut m MyReaderWriter) write(buf string) string {
	println('writing ${buf} to file...')
	return buf
}
