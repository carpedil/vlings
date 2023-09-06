module algorithm

// binary_search_index only for sorted array
fn binary_search_index(array []int, search_value int) (string, int) {
	mut lower_bound := 0
	mut upper_bound := array.len - 1
	mut count := 1
	for {
		if lower_bound <= upper_bound {
			mid_point := (lower_bound + upper_bound) / 2
			value_at_mid_point := array[mid_point]
			println('value at mid point[${mid_point}] is ${value_at_mid_point}')
			if search_value == value_at_mid_point {
				return 'right there,after ${count} steps, found the index of value ${search_value} is ', mid_point
			} else if search_value < value_at_mid_point {
				upper_bound = mid_point - 1
			} else if search_value > value_at_mid_point {
				lower_bound = mid_point + 1
			}
			count += 1
		} else {
			break
		}
	}
	return 'oops, after ${count} steps , can not found the index of ${search_value}', -1
}

fn test_binary_search() {
	arr := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
		24, 25, 26, 27, 28, 29, 30, 31, 32]
	println(binary_search_index(arr, 2))
	println(binary_search_index(arr, 10))
	println(binary_search_index(arr, 15))
	println(binary_search_index(arr, 16))
	println(binary_search_index(arr, 17))
	println(binary_search_index(arr, 5))
	println(binary_search_index(arr, 25))
	println(binary_search_index(arr, 31))
	println(binary_search_index(arr, 41))
}
