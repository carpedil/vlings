<script lang="ts">
	import type { ApiData } from '$lib';
	import { onMount } from 'svelte';
	import Apiinfo from './apiinfo.svelte';
	export let api_list: ApiData[] = [];

	let api: ApiData | undefined = {
		id: 0,
		srv_id: 0,
		api_name: '',
		api_content: '',
		api_param: [],
		test_count: 0
	};

	onMount(() => {
		console.log(api_list);
	});

	const handleApiClick = (evt: any) => {
		evt.preventDefault();
		const api_name = evt.target.getAttribute('value');
		console.log(api_name);
		api = api_list.find((api) => api.api_name === api_name);
		console.log(api);
	};
</script>

<!-- container -->
<div class="border bg-white h-[15vh] p-1">
	<h1 class=" border-b-red-700">API LIST:</h1>
	<div class="h-[12vh] w-full float-left overflow-y-scroll scroll-auto">
		{#each api_list as api}
			<input
				type="button"
				value={api.api_name}
				class="border bg-slate-400 p-1 m-1 text-sm text-yellow-50 hover:bg-orange-600 rounded-md"
				on:click={handleApiClick}
			/>
		{/each}
	</div>
</div>
<Apiinfo {api} />
