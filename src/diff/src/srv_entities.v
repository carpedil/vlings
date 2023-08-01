module main

[table: 'srv_data']
struct SrvData {
	id          int       [primary; sql: serial]
	srv_name    string    [nonnull; sql_type: 'TEXT'; unique] // 服务名
	default_hdr string    [sql_type: 'TEXT']
	api_list    []ApiData [fkey: 'srv_id']
}

struct SrvDataDto {
mut:
	id          int
	srv_name    string
	default_hdr string
	api_list    []ApiDataDto
}
