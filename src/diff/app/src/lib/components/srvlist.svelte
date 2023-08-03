<script lang="ts">
	import { onMount } from 'svelte';
	import { base_url } from '$lib/stores';
	import Apiwarpper from './apiwarpper.svelte';
	import type { SrvData } from '$lib';

	let srv_list: SrvData[] = [];
	let select_srv: SrvData = {
		id: '',
		srv_name: '',
		default_hdr: '',
		api_list: []
	};
	onMount(async () => {
		// todo: get all srv list data
		const req = await fetch(`${$base_url}/api/srv/list`, {
			method: 'GET'
		});
		const res = await req.json();

		srv_list = res;
		console.log(srv_list);
		select_srv = srv_list[0];
	});

	const handleClick = (evt: any) => {
		let curr_srv_id = evt.target.dataset.srv_id;
		select_srv = srv_list[curr_srv_id - 1];
	};
</script>

<div class="border w-[12vw] p-1">
	<span class="border-t-0 border-l-0 border-r-0 border">SRV LIST:</span>
	<div class="flex flex-col">
		{#each srv_list as srv}
			<label for={srv.id}>
				<input
					type="radio"
					name="srvlist"
					id={srv.id}
					value={srv.srv_name}
					checked={srv.id == '1'}
					data-srv_id={srv.id}
					on:click={handleClick}
					class="border text-left w-auto p-0.5 hover:text-white hover:bg-red-500 focus:bg-red-600 focus:text-white rounded-sm"
				/>
				{srv.srv_name}
			</label>
		{/each}
	</div>
</div>
<div class="border w-[90vw] ml-1">
	<Apiwarpper api_list={select_srv.api_list} />
</div>
