<script lang="ts">
	import { onMount } from 'svelte';
	import Srvlist from '$lib/components/srvlist.svelte';

	let hello: string = '';
	onMount(async () => {
		let req = await fetch('http://localhost:8082/api/test/hello', {
			method: 'GET'
		});
		hello = await req.json();
		console.log(hello);
	});
</script>

<p class="h1">{hello}</p>
<div class="flex flex-row justify-start h-[100vh] p-1 mt-[5px] text-lg">
	<Srvlist />
</div>
