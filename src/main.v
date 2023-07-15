module main

import custom_err { try_open }

fn main() {
	try_open('/tmp') or { panic(err)  }
}
