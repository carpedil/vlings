// place files you want to import through the `$lib` alias in this folder.

export type Param = {
	key: string;
	value: string;
	is_required: boolean;
};
export type ApiData = {
	id: number;
	srv_id: number;
	api_name: string;
	api_content: string;
	api_param: Param[];
	test_count: number;
	is_inuse: string;
};
export type SrvData = {
	id: string;
	srv_name: string;
	default_hdr: string;
	api_list: ApiData[];
};

class TestConfig {
	base_url:string = 'http://127.0.0.1:8090'
	local_tcp_srv_list: string[]= ['127.0.0.1:8091','127.0.0.1:8092']
	socket_host :   string= '127.0.0.1'
	socket_port :   number = 30000
}

class Config {
	base_url:string = 'http://10.8.3.125:8090'
	local_tcp_srv_list: string[]= ['10.9.64.28:6612','10.162.138.83:6612']
	socket_host :   string= '10.8.3.125'
	socket_port :   number = 30000
}

export const new_test_config = ():TestConfig => {
	return new TestConfig()
}

export const new_config = ():Config => {
	return new Config()
}