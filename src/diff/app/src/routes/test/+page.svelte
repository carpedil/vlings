<script lang="ts">
	import { onMount } from 'svelte';
	import { base_url } from '$lib/stores';
	import Srvlist from '$lib/components/srvlist.svelte';

	let hello: string = '';
	onMount(async () => {
		let req = await fetch(`${$base_url}/api/test/hello`, {
			method: 'GET'
		});
		hello = await req.json();
		console.log(hello);
	});
</script>

<div class="flex flex-row justify-start border w-full h-screen p-1">
	<Srvlist />
</div>
