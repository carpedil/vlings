<script lang="ts">
	let srv_list = [
		'LOT_SRV',
		'EQP_SRV',
		'CUSTOM_SRV',
		'QUERY_SRV',
		'CST_SRV',
		'INQUIRY_SRV',
		'ESF_SRV',
		'DCOL_SRV',
		'SQC_SRV',
		'ALM_SRV',
		'CLOT_SRV',
		'CQUERY_SRV',
		'CINQUIRY_SRV',
		'PFBS_SRV',
		'PFBS2_SRV',
		'CFBS_SRV',
		'RMS_SRV',
		'SPDN_SRV',
		'EFBS_SRV',
		'APCR2R_SRV',
		'DISPATCH_SRV',
		'EOCAP_SRV',
		'SHOPFLOOR_SRV',
		'ROBOT_SRV',
		'LOG_SRV'
	];

	const submit = () => {
		const srv_name = document.getElementById('SRVLIST') as HTMLSelectElement;
        const api_content = document.getElementById('api_content') as HTMLSelectElement
		console.log(srv_name.value,api_content.value);
        save(srv_name.value,api_content.value)
	};
    const save =async (srv_name:string, api_content:string) => {
        const req = await fetch('http://localhost:8082/api/save',{
            method:'POST',
            body: JSON.stringify({
                srv_name: srv_name,
                api_content: api_content
            })
        })
        const res = await req.json();
        alert(res);
    }
</script>

<div class="flex flex-row justify-center mt-[100px] text-lg">
	<div>
		SRV NAME:

		<select name="SRV_LIST" id="SRVLIST" class="ml-5 mr-5">
			{#each srv_list as srv, index}
				<option value={srv} selected={index == 2}>{srv}</option>
			{/each}
		</select>
		<input
			type="submit"
			value="SAVE"
			class="border pr-4 pl-4  bg-red-600 text-white"
			on:click={submit}
		/>
        <hr>
		<div>
			<div>API CONTENT:</div>
			<div>
				<textarea class="border w-[65vw]" id="api_content" name='api_content'/>
			</div>
		</div>
	</div>
</div>
