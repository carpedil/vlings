module mutexes

struct DataModel1 {
mut:
	data int
}

fn worker(shared model DataModel1) {
	rlock model {
		println(model.data)
	}
}

fn test_worker1() {
	shared model := DataModel1{
		data: 10
	}

	h := spawn worker(shared model)

	h.wait()
}

struct DataModel2 {
mut:
	data int
}

fn (shared model DataModel2) worker() {
	lock model {
		println('before change ,data = ${model.data}')
		model.data = 200
		println('after change ,data = ${model.data}')
	}
}

fn test_worker2() {
	shared model := DataModel2{
		data: 100
	}

	h := spawn model.worker()

	h.wait()
}
