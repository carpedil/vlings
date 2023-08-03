<script lang="ts">
	import type { ApiData } from '$lib';
	import Messagewarpper from './messagewarpper.svelte';

	export let api: ApiData | undefined;
	let msg: string = '';
	$: {
		let tmp_msg = '';
		if (api != undefined) {
			api.api_param.forEach((p) => {
				tmp_msg += `${p.key}=${
					p.value.includes(' ') && p.key != 'HDR'
						? `"${p.value.toUpperCase()}" `
						: `${p.value.toUpperCase()} `
				} `;
			});
		}
		msg = `${api?.api_name} ${tmp_msg}`;
		// console.log(msg);
	}
</script>

<div class="border-2 bg-white h-[7vh] w-full p-1 flex items-center">
	{#if api != undefined}
		<div
			class={api.api_content === ''
				? ''
				: 'w-full bg-blue-500 p-0.5 text-sm text-red-100 rounded-md overflow-x-scroll'}
		>
			{api.api_content === '' ? '' : api.api_content}
		</div>
	{/if}
</div>
<div class="bg-white h-[74vh] p-1">
	<div class="flex flex-row justify-start">
		<div class="border w-[35vw] h-[74vh] p-1">
			{#if api != undefined}
				{#each api.api_param as param}
					<div class="border">
						<label for={param.key} class="w-[10vw]"
							>{param.key}=<input
								type="text"
								name={param.key}
								id={param.key}
								bind:value={param.value}
								on:change={() => (param.value = param.value.toUpperCase())}
								required={param.is_required}
								class="w-[24vw] border float-right text-left text-slate-600 bg-slate-300"
							/>
						</label>
					</div>
				{/each}
			{/if}
		</div>
		<Messagewarpper {msg} />
	</div>
</div>
