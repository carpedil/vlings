module concurrency

import time

fn sum(values []int, res_ch chan int) {
	mut sum := 0
	for val in values {
		println('${sum} + ${val} = ${sum + val}')
		sum += val
	}
	res_ch <- sum
}

fn test_sum() {
	values := [1, 2, 3, 4]
	ch := chan int{}

	spawn sum(values[..values.len / 2], ch)
	spawn sum(values[values.len / 2..], ch)

	res1 := <-ch
	res2 := <-ch
	println(res1)
	println(res2)
	println(res1 + res2)
}

fn test_buf_chan() {
	buf_chan := chan int{cap: 2}
	buf_chan <- 1
	buf_chan <- 3
	println(<-buf_chan)
	println(<-buf_chan)
	buf_chan <- 2
	println(<-buf_chan)
	println('done')
}

fn test_close_chan() {
	ch := chan int{}
	ch.close()

	m := <-ch or {
		println('channel has been closed')
		-1
	}
	println(m)
}

fn test_loop_chan() {
	ch := chan int{cap: 5}
	for i in 0 .. 5 {
		ch <- i
	}
	println('channel will be closed')
	ch.close()
	println('channel closed')

	for {
		m := <-ch or { break }
		println(m)
	}

	println('done')
}

fn fibonacci(c chan int, quit chan int) {
	mut x, mut y := 0, 1

	for {
		select {
			c <- x {
				x, y = y, x + y
			}
			_ := <-quit {
				println('quit')
				return
			}
		}
	}
}

fn test_select_chan() {
	ch := chan int{}
	quit := chan int{}
	spawn fn [ch, quit] () {
		for _ in 0 .. 10 {
			println(<-ch)
		}
		quit <- 0
	}()

	fibonacci(ch, quit)
}

fn test_timeout_chan() {
	ch := chan int{}
	select {
		val := <-ch {
			println(val)
		}
		2 * time.second {
			println('timeout')
		}
	}
}

fn test_else_ch() {
	ch := chan int{}
	select {
		val := <-ch {
			println(val)
		}
		else {
			println('no values in ch for now')
		}
	}
}

struct Abc {
	x int
}

fn test_special_func() {
	a := 2.14
	ch := chan f64{}
	defer {
		ch.close()
	}
	res := ch.try_push(a) // ch <- a
	println(res)

	l := ch.len
	c := ch.cap
	is_closed := ch.closed
	println(is_closed)
	println(l)
	println(c)

	mut b := Abc{
		x: 10
	}
	ch2 := chan Abc{}
	res2 := ch2.try_pop(mut b) // b = <- ch2
	println(res2)
}
