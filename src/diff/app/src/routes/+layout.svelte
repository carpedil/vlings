<script>
	import { onMount } from 'svelte';
	import { base_url, ws_url, remot_srv_addrs } from '$lib/stores';
	import '../app.postcss';
	onMount(async () => {
		const req = await fetch('/api/config', {
			method: 'GET'
		});
		const res = await req.json();
		console.log(res);
		base_url.set(res.base_url);
		ws_url.set(res.ws_url);
		remot_srv_addrs.set(res.srv_addrs);
	});
</script>

<nav class="flex flex-row list-none justify-evenly bg-slate-500 text-white sticky top-0">
	<li><a href="/">New Api</a></li>
	<li><a href="/test">Test</a></li>
</nav>
<slot />
