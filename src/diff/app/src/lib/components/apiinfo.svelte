<script lang="ts">
	import type { ApiData } from '$lib';

	export let api: ApiData | undefined;
	$: console.log(api);
</script>

<div class="border bg-white h-[7vh] p-1">
	{#if api != undefined}
		<div class="mb-1">
			<span class=" border-b-red-700">API INFO: </span><span
				class=" bg-blue-500 p-0.5 text-sm text-red-100 rounded-md"
				>{api.api_content === '' ? '' : api.api_content}</span
			>
		</div>
	{/if}
</div>
<div class="bg-white h-[73vh] p-1">
	<h1>received message:</h1>
	<div class="flex flex-row justify-evenly">
		<div class="border w-[45vw] h-[73vh] p-1">
			{#if api != undefined}
				{#each api.api_param as param}
					<div class="flex-1 border">
						<label for={param.key}
							>{param.key}=<input
								type="text"
								name={param.key}
								id={param.key}
								bind:value={param.value}
								on:change={() => (param.value = param.value.toUpperCase())}
								required={param.is_required}
								class="border float-right text-left"
							/>
						</label>
					</div>
				{/each}
			{/if}
		</div>
		<div class="border w-full h-[73vh] p-1">left:</div>
		<div class="border w-full h-[73vh] p-1">right</div>
	</div>
</div>
