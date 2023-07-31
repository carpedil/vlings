<script lang="ts">
	import { onMount } from 'svelte';
	import Apiwarpper from './apiwarpper.svelte';
	import type { SrvData } from '$lib';

	let srv_list: SrvData[] = [];
	let select_srv: SrvData = {
		id: '',
		srv_name: '',
		api_list: []
	};
	onMount(async () => {
		// todo: get all srv list data
		const req = await fetch('http://localhost:8082/api/srv/list', {
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

<div class="border w-[10vw] p-1">
	<span class=" text-blue-700">SRV LIST:</span>
	<div class="flex flex-col">
		{#each srv_list as srv}
			<label for={srv.id} class="hover:bg-orange-600 hover:text-white rounded-sm"
				><input
					type="radio"
					name="srvlist"
					id={srv.id}
					checked={srv.id == '1'}
					data-srv_id={srv.id}
					on:click={handleClick}
				/>{srv.srv_name}</label
			>
		{/each}
	</div>
</div>
<div class="border w-[90vw] ml-1">
	<Apiwarpper api_list={select_srv.api_list} />
</div>
