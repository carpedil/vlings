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
