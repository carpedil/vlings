module custom_err

struct PathError {
	Error
	path string
}

fn (pe PathError) msg() string {
	return 'Failed to open path: ${pe.path}'
}

pub fn try_open(path string) ? {
	return PathError{
		path: path
	}
}
