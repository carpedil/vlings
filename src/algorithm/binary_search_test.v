module algorithm

// binary_search only for sorted array
fn binary_search(array []int, value int) (string, int) {
	mut lower_bound := 0
	mut upper_bound := array.len - 1
	mut count := 1
	for {
		if lower_bound <= upper_bound {
			mind_point := (lower_bound + upper_bound) / 2
			value_at_mind_point := array[mind_point]
			// println("value at mind point is ${value_at_mind_point}")

			if value == value_at_mind_point {
				return 'right here,after ${count} steps, the index of value ${value} is ', mind_point
			} else if value < value_at_mind_point {
				upper_bound = mind_point - 1
			} else if value > value_at_mind_point {
				lower_bound = mind_point + 1
			}
			count += 1
		} else {
			break
		}
	}
	return 'not found', -1
}

fn test_binary_search() {
	arr := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
		24, 25, 26, 27, 28, 29, 30, 31, 32]
	println(binary_search(arr, 2))
	println(binary_search(arr, 10))
	println(binary_search(arr, 15))
	println(binary_search(arr, 16))
	println(binary_search(arr, 17))
	println(binary_search(arr, 5))
	println(binary_search(arr, 25))
	println(binary_search(arr, 31))
	println(binary_search(arr, 41))
}
