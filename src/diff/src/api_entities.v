module main

[table: 'api_data']
struct ApiData {
	id          int    [primary; sql: serial]
	srv_id      int    [nonnull] // 服务名
	api_name    string [nonnull; sql_type: 'TEXT']
	api_content string [nonnull; sql_type: 'TEXT']
	api_param   string [nonnull; sql_type: 'TEXT']
	test_count  int    [default: '0'] // 测试次数，不太准确，但可以作为排序算法的参数。 有利于SNI
	is_inuse 	string   [default: 'Y']
}



struct ApiDataDto {
mut:
	id          int
	srv_id      int
	api_name    string
	api_content string
	api_param   []Param
	test_count  int
	is_inuse 	string 
}

struct Param {
	key         string
	value       string
	is_required bool
}