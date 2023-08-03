<script lang="ts">
	import type { SrvData, ApiData } from '$lib';
	import { base_url } from '$lib/stores';
	import { onMount } from 'svelte';

	let curr_srv_api: ApiData[] = [];
	let srv_list: SrvData[] = [];
	let output: string = '';
	let default_hdr: string = '';

	const submit_api = () => {
		const selected_srv = document.getElementById('srv_list') as HTMLSelectElement;
		let api_content = document.getElementById('api_content') as HTMLSelectElement;
		console.log(selected_srv.value, api_content.value);
		save_api(Number(selected_srv.value), api_content.value.toUpperCase());
		api_content.value = '';
	};

	const submit_srv = () => {
		let srv_name = document.getElementById('srv_name') as HTMLSelectElement;

		console.log(srv_name.value);
		save_srv(srv_name.value, default_hdr);
		srv_name.value = '';
		default_hdr = '';
	};
	const delApi = (evt: any) => {
		console.log(evt.target.dataset);
		if (confirm('Are you sure you want to delete this API?')) {
			del_api(Number(evt.target.dataset.api_id));
		}
	};

	const del_api = async (id: number) => {
		localStorage.removeItem('output');
		const req = await fetch(`${$base_url}/api/del`, {
			method: 'POST',
			body: JSON.stringify({
				id: id
			})
		});
		const res = await req.json();
		localStorage.setItem('output', JSON.stringify(res, null, 4));
		window.location.reload();
	};

	const apiValidation = (evt: any) => {
		validation_api(Number(evt.target.dataset.api_id), evt.target.dataset.validation);
	};

	const validation_api = async (id: number, curr_validation: string) => {
		localStorage.removeItem('output');
		const req = await fetch(`${$base_url}/api/validation`, {
			method: 'POST',
			body: JSON.stringify({
				id: id,
				validation: curr_validation == 'Y' ? 'N' : 'Y'
			})
		});
		const res = await req.json();
		console.log(res);
		localStorage.setItem('output', JSON.stringify(res, null, 4));
		window.location.reload();
	};

	const save_api = async (srv_id: number, api_content: string) => {
		localStorage.removeItem('output');
		if (api_content == '' || api_content == null) {
			alert('Please enter API content');
			return;
		}
		const req = await fetch(`${$base_url}/api/add`, {
			method: 'POST',
			body: JSON.stringify({
				srv_id: srv_id,
				api_content: api_content
			})
		});
		const res = await req.json();

		localStorage.setItem('output', JSON.stringify(res, null, 4));
		window.location.reload();
	};

	const save_srv = async (srv_name: string, default_hdr: string) => {
		localStorage.removeItem('output');
		if (srv_name == '' || srv_name == null) {
			alert('Please enter Srv Name');
			return;
		}
		const req = await fetch(`${$base_url}/api/srv/add`, {
			method: 'POST',
			body: JSON.stringify({
				srv_name: srv_name,
				default_hdr: default_hdr
			})
		});
		const res = await req.json();
		localStorage.setItem('output', JSON.stringify(res, null, 4));
		window.location.reload();
	};

	const handleSelect = (evt: any) => {
		localStorage.removeItem('selected_srv_id');
		let select_srv_id = evt.currentTarget.value;

		localStorage.setItem('selected_srv_id', select_srv_id);

		curr_srv_api = srv_list.filter((srv: any) => {
			return srv.id == select_srv_id;
		})[0].api_list;
		console.log('selected_srv_data:\n', curr_srv_api);
	};
	onMount(async () => {
		const req = await fetch(`${$base_url}/api/srv/list`, {
			method: 'GET'
		});
		const res = await req.json();

		srv_list = res;
		// console.log(srv_list);
		// set default api_list for the first srv name in the list
		const id = Number(localStorage.getItem('selected_srv_id'));
		curr_srv_api = id ? srv_list[id - 1].api_list : srv_list[0].api_list;
		console.log(curr_srv_api);
		output = localStorage.getItem('output')!;
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
							<option value={srv.id} selected={srv.id == localStorage.getItem('selected_srv_id')}
								>{srv.srv_name}</option
							>
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
						<input
							class="border w-full"
							id="api_content"
							name="api_content"
							placeholder="Enter the Api Content."
						/>
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
				<input
					class="border w-full"
					id="srv_name"
					name="srv_name"
					placeholder="Enter the Srv Name."
				/>
				<input
					class="border w-full"
					id="default_hdr"
					name="default_hdr"
					bind:value={default_hdr}
					placeholder="Enter the default_hdr for the new Srv."
				/>
			</div>
		</div>
	</div>
	<div class="border bg-white w-full h-[74vh]">
		<div class="h-[44vh] overflow-y-scroll border">
			<table class="w-full border border-separate text-sm">
				<tr class="bg-white text-left sticky top-0">
					<th class="w-[2vw] text-center bg-blue-600 text-white">{curr_srv_api.length}</th>
					<th class="w-[9vw]">API_NAME</th>
					<th>API CONTENT</th>
					<th class="w-[4vw] text-center">VALID</th>
					<th class="w-[5vw] text-center">TEST CNT</th>
					<th class="w-[6vw] text-center">OPERATION</th>
				</tr>
				{#each curr_srv_api as api, index}
					<tr class=" hover:bg-blue-400 hover:text-white">
						<td class="border text-center">{index + 1}</td>
						<td class="border">{api.api_name}</td>
						<td class="border">{api.api_content}</td>
						<td
							class="border text-center {api.is_inuse == 'Y'
								? `bg-green-400 text-white`
								: `bg-red-400 text-white`} rounded-sm">{api.is_inuse}</td
						>
						<td class="border text-center">{api.test_count}</td>
						<td class="border text-center float-left">
							<input
								type="button"
								value="DEL"
								class="text-red-500"
								data-api_id={api.id}
								on:click={delApi}
							/>
							<input
								type="button"
								value={api.is_inuse == 'Y' ? `INVLALID` : `VALID`}
								class="text-blue-500"
								data-api_id={api.id}
								data-validation={api.is_inuse}
								on:click={apiValidation}
							/>
						</td>
					</tr>
				{/each}
			</table>
		</div>
		<hr />
		<div class="h-[28vh] overflow-y-scroll text-sm p-1">
			<pre>{output ? output : ''}</pre>
		</div>
	</div>
</div>
