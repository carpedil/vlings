<script lang="ts">
	import { afterUpdate, onMount } from 'svelte';
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
	let output:string = ''


	const submit_api = () => {
		const selected_srv = document.getElementById('srv_list') as HTMLSelectElement;
		let api_content = document.getElementById('api_content') as HTMLSelectElement;
		console.log(selected_srv.value, api_content.value);
		save_api(Number(selected_srv.value), api_content.value.toUpperCase());
		api_content.value = ''
	};

	const submit_srv = () => {
		let srv_name = document.getElementById('srv_name') as HTMLSelectElement;

		console.log(srv_name.value);
		save_srv(srv_name.value);
		srv_name.value = ''
	};
	const save_api = async (srv_id: number, api_content: string) => {
		output = ''
		const req = await fetch('http://localhost:8082/api/add', {
			method: 'POST',
			body: JSON.stringify({
				srv_id: srv_id,
				api_content: api_content
			})
		});
		const res = await req.json();
		
		// window.location.reload(); 
		output = res;
		curr_srv_api = srv_list.filter((srv: any) => {
			return srv.id == select_srv;
		})[0].api_list;
	};

	const save_srv = async (srv_name: string) => {
		output = ''
		const req = await fetch('http://localhost:8082/api/srv/add', {
			method: 'POST',
			body: JSON.stringify({
				srv_name: srv_name
			})
		});
		const res = await req.json();
		window.location.reload(); 
		output = res;
	};

	const handleSelect = (evt: any) => {
		select_srv = evt.currentTarget.value;
		console.log(select_srv)
		curr_srv_api = srv_list.filter((srv: any) => {
			return srv.id == select_srv;
		})[0].api_list;
		console.log('=======>\n',curr_srv_api)
	};
	onMount(async () => {
		const req = await fetch('http://localhost:8082/api/srv/list', {
			method: 'GET'
		});
		const res = await req.json();

		srv_list = res;
		console.log(srv_list)
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
						{#each srv_list as srv}
							<option value={srv.id} selected={srv.id == '5'}>{srv.srv_name}</option>
						{/each}
					</select>
					<input
						type="submit"
						value="NEW API"
						class="border pr-4 pl-4 bg-red-600 text-white float-right rounded-sm"
						on:click={submit_api}
						disabled
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
					disabled
				/>
				<input class="border w-full" id="srv_name" name="srv_name" placeholder="Enter the Srv Name."/>
			</div>
		</div>
	</div>
	<div class="border bg-white w-full h-[74vh]">
		<div class="h-[44vh] overflow-y-scroll border">
			<table class="w-full border border-separate">
				<tr class="text-left">
					<th class="w-[2vw] text-center">#</th>
					<th class="w-[10vw]">API_NAME</th>
					<th>API CONTENT</th>
					<th class="w-[6vw] text-center">TEST CNT</th>
				</tr>
				{#each curr_srv_api as api, index}
					<tr>
						<td class="border text-center">{index+1}</td>
						<td class="border">{api.api_name}</td>
						<td class="border">{api.api_content}</td>
						<td class="border text-center">{api.test_count}</td>
					</tr>
				{/each}
			</table>
		</div>
		<hr>
		<div class="h-[28vh] overflow-y-scroll text-sm p-1">
			<pre>{output ? JSON.stringify(output,null,4) : ''}</pre>
		</div>
	</div>
</div>
