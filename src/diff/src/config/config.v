module config

pub struct TestConfig {
pub:
	host_ip        string
	port           int
	local_tcp_addr string
	socket_host    string
	socket_port    int
}

pub fn new_test_config() TestConfig {
	return TestConfig{
		host_ip: '127.0.0.1'
		port: 8090
		local_tcp_addr: '127.0.0.1:6020'
		socket_host: '127.0.0.1'
		socket_port: 30000
	}
}

pub struct Config {
pub:
	host_ip        string
	port           int
	local_tcp_addr string
	socket_host    string
	socket_port    int
}

pub fn new_config() Config {
	return Config{
		host_ip: '10.8.3.125'
		port: 8090
		local_tcp_addr: '10.8.3.125:6020'
		socket_host: '10.8.3.125'
		socket_port: 30000
	}
}
