module concurrency

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
