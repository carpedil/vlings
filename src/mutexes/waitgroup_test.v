module mutexes

import sync
import time

fn worker(id int) {
	println('Worker ${id} starting')
	time.sleep(time.second)
	println('Worker ${id} starting')
}

fn test_wg() {
	mut wg := sync.new_waitgroup()

	for i in 0 .. 5 {
		wg.add(1)
		spawn fn [mut wg, i] () {
			defer {
				wg.done()
			}
			worker(i)
		}()
	}

	wg.wait()
}
