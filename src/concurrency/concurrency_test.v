module concurrency

import math
import time

fn do_math(a f64, b f64) {
	println('do_math calling...')
	c := math.sqrt(a * a + b * b)
	println(c)
	println('do_math out...')
}

fn test_do_math() {
	spawn do_math(4, 5)
}

fn test_anonymous_spawn() {
	spawn fn (a f64, b f64) {
		c := math.sqrt(a * a + b * b)
		println(c)
	}(3, 4)
}

fn test_handle_spawn() {
	println('main thread start ...')
	h := spawn do_math(6, 7)

	h.wait()
	println('main thread ended ...')
}

fn get_hypot(a f64, b f64) f64 {
	return math.sqrt(a * a + b * b)
}

fn test_get_hypot() {
	handler := spawn get_hypot(54.06, 2.8)
	res1 := get_hypot(2.32, 16.74)
	res2 := handler.wait() // get the return data from thread
	println('Results: ${res1}, ${res2}')
}

fn task(id int, duration int) {
	println('task ${id} begin...')
	time.sleep(duration * time.millisecond)
	println('task ${id} end...')
}

fn test_task() {
	mut threads := []thread{}

	threads << spawn task(1, 500)
	threads << spawn task(2, 900)
	threads << spawn task(3, 200)

	threads.wait()
	println('done')
}

fn expensive_computing(i int) int {
	return i * i
}

fn test_expensive_computing() {
	mut threads := []thread int{}

	for i in 0 .. 10 {
		threads << spawn expensive_computing(i)
	}
	r := threads.wait()
	println('all job finished: ${r}')
}

[spawn_stack: 65536]
fn watcher() {
	println('hello')
}

fn test_watcher() {
	h := spawn watcher()
	h.wait()
}
