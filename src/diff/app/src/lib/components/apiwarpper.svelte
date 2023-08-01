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
		test_count: 0,
		is_inuse: 'Y'
	};

	onMount(() => {
		console.log(api_list);
	});

	const handleApiClick = (evt: any) => {
		evt.preventDefault();
		const api_name = evt.target.getAttribute('value');
		api = api_list.find((api) => api.api_name === api_name);
		console.log(api);
	};
</script>

<!-- container -->
<div class="border bg-white h-[15vh] p-1">
	<span class="border border-t-0 border-l-0 border-r-0">API LIST:</span>
	<div class="h-[12vh] w-full float-left overflow-y-scroll scroll-auto">
		{#each api_list as api}
			<input
				type="button"
				value={api.api_name}
				class="border {api.is_inuse == 'Y'
					? `bg-green-400`
					: `bg-red-400 `} p-1 m-1 text-sm text-yellow-50 hover:bg-blue-500 active:bg-blue-500 focus:bg-blue-500 rounded-md"
				on:click={handleApiClick}
			/>
		{/each}
	</div>
</div>
<Apiinfo {api} />
