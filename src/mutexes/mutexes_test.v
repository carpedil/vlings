module mutexes

import sync
import time

struct SafeCounter {
mut:
	mt sync.Mutex
pub mut:
	value map[string]int
}

fn (mut c SafeCounter) inc(key string) {
	c.mt.@lock() // acquire the mutex
	defer {
		c.mt.unlock() // automatically release the mutex
	}
	c.value[key]++ // this code is executed only by one thread at a time
}

fn (mut c SafeCounter) value(key string) int {
	c.mt.@lock() // acquire the mutex
	defer {
		c.mt.unlock() // automatically release the mutex
	}
	return c.value[key] // this code is executed only by one thread at a time
}

fn test_safe_counter() {
	mut counter := &SafeCounter{
		mt: sync.new_mutex()
		// create a new mutex
	}

	for i := 0; i < 5; i++ {
		spawn fn [mut counter, i] () {
			for j := 0; j < 10; j++ {
				println('thread ${i} processing ${j + 1} times')
				counter.inc('key')
				println('thread ${i} done')
			}
		}()
	}

	time.sleep(1 * time.second)
	println(counter.value('key'))
}
