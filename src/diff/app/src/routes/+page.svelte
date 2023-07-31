<script lang="ts">
	import { onMount } from 'svelte';
	type Param = {
		key: string;
		value: string;
		is_required: boolean;
	};
	type ApiData = {
		id: number;
		srv_id: number;
		api_name: string;
		api_content: string;
		api_param: Param[];
		test_count: number;
	};
	type SrvData = {
		id: string;
		srv_name: string;
		api_list: ApiData[];
	};

	let select_srv: SrvData;
	let curr_srv_api: ApiData[] = [];
	let srv_list: SrvData[] = [];


	const submit_api = () => {
		const srv_name = document.getElementById('srv_list') as HTMLSelectElement;
		const api_content = document.getElementById('api_content') as HTMLSelectElement;
		console.log(srv_name.value, api_content.value);
		save_api(srv_name.value, api_content.value.toUpperCase());
	};

	const submit_srv = () => {
		const srv_name = document.getElementById('srv_name') as HTMLSelectElement;

		console.log(srv_name.value);
		save_srv(srv_name.value);
	};
	const save_api = async (srv_name: string, api_content: string) => {
		const req = await fetch('http://localhost:8082/api/add', {
			method: 'POST',
			body: JSON.stringify({
				srv_name: srv_name,
				api_content: api_content
			})
		});
		const res = await req.json();
		alert(res);
	};

	const save_srv = async (srv_name: string) => {
		const req = await fetch('http://localhost:8082/api/srv/add', {
			method: 'POST',
			body: JSON.stringify({
				srv_name: srv_name
			})
		});
		const res = await req.json();
		alert(res);
	};

	const handleSelect = (evt: any) => {
		select_srv = evt.currentTarget.value;
		curr_srv_api = srv_list.filter((srv: any) => {
			return srv.srv_name == select_srv;
		})[0].api_list;
	};
	onMount(async () => {
		const req = await fetch('http://localhost:8082/api/srv/list', {
			method: 'GET'
		});
		const res = await req.json();

		srv_list = res;
		// set default api_list for the first srv name in the list
		curr_srv_api = srv_list[0].api_list;
	});
</script>

<div class="border w-full h-screen p-1 bg-gray-200">
	<div class="border bg-white w-full h-60 flex flex-row justify-between pt-1 pl-1">
		<div class="border w-[79vw] h-57">
			<div>
				<div>
					SRV NAME:

					<select name="srv_list" id="srv_list" class="ml-5 mr-5" on:change={handleSelect}>
						{#each srv_list as srv, index}
							<option value={srv.srv_name} selected={index == 2}>{srv.srv_name}</option>
						{/each}
					</select>
					<input
						type="submit"
						value="NEW API"
						class="border pr-4 pl-4 bg-red-600 text-white float-right rounded-sm"
						on:click={submit_api}
					/>
				</div>
				<hr />
				<div>
					<div>API CONTENT:</div>
					<div>
						<input class="border w-full" id="api_content" name="api_content" placeholder="Enter the Api Content."/>
					</div>
				</div>
			</div>
		</div>
		<div class="border w-[29vw] h-57">
			<div>
				SRV NAME:
				<input
					type="submit"
					value="NEW SRV"
					class="border pr-4 pl-4 bg-orange-600 text-white float-right rounded-sm"
					on:click={submit_srv}
				/>
				<input class="border w-full" id="srv_name" name="srv_name" placeholder="Enter the Srv Name."/>
			</div>
		</div>
	</div>
	<div class="border bg-white w-full h-[74vh]">
		<div class="h-[45vh] overflow-y-scroll">
			<table class="w-full border border-separate">
				<tr class="text-left">
					<th class="w-[2vw] text-center">#</th>
					<th class="w-[10vw]">API_NAME</th>
					<th>API CONTENT</th>
					<th class="w-[6vw] text-center">TEST CNT</th>
				</tr>
				{#each curr_srv_api as api, index}
					<tr>
						<td class="border text-center">{index}</td>
						<td class="border">{api.api_name}</td>
						<td class="border">{api.api_content}</td>
						<td class="border text-center">{api.test_count}</td>
					</tr>
				{/each}
			</table>
		</div>
	</div>
</div>
