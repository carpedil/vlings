module config

struct BaseData {
	base_url  string
	srv_addrs []string
	ws_url    string
}

pub struct TestConfig {
pub:
	host_ip        string
	port           int
	base_data      BaseData
	local_tcp_addr string
	socket_host    string
	socket_port    int
}

pub fn new_test_config() TestConfig {
	return TestConfig{
		host_ip: 'localhost'
		port: 8090
		base_data: BaseData{
			base_url: 'http://localhost:8090'
			srv_addrs: [
				'localhost:8091',
				'localhost:8092',
			]
			ws_url: 'ws://localhost:30000'
		}
		local_tcp_addr: 'localhost:6020'
		socket_host: 'localhost'
		socket_port: 30000
	}
}

pub struct Config {
pub:
	host_ip        string
	port           int
	base_data      BaseData
	local_tcp_addr string
	socket_host    string
	socket_port    int
}

pub fn new_config() Config {
	return Config{
		host_ip: '10.8.3.125'
		port: 8090
		base_data: BaseData{
			base_url: 'http://10.8.3.125:8090'
			srv_addrs: [
				'10.9.64.28:6612',
				'10.162.138.83:6612',
			]
			ws_url: 'ws://10.8.3.125:30000'
		}
		local_tcp_addr: '10.8.3.125:6020'
		socket_host: '10.8.3.125'
		socket_port: 30000
	}
}
