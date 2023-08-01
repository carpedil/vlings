<script lang="ts">
	import { onMount } from 'svelte';

	export let msg: string;
	let srv_ip_list: string[] = [];

	const handleSend = async () => {
		srv_ip_list = getSrvIpList();

		if (msg.length <= 1) {
			alert(
				'Api message can not be send with nothing, Select the api to be tested and enter the correct test data.'
			);
			return;
		}
		if (srv_ip_list.length == 0) {
			alert(
				'The IP address of the server to be tested cannot be empty. Select at least one of the server IP addresses to send test information.'
			);
			return;
		}

		console.log(`Sending msg ${msg} to ${srv_ip_list.toString()}`);
		const req = await fetch('http://localhost:8082/api/message/send', {
			method: 'POST',
			body: JSON.stringify({
				msg: msg,
				srv_ip_list: srv_ip_list
			})
		});
		const res = await req.json();
		console.log(res);
		// alert(res.msg);
	};

	const getSrvIpList: () => string[] = () => {
		let ip_list: string[] = [];
		// Get all the checkboxes with the name "test_srv_list"
		let checkboxes = document.getElementsByName('test_srv_list');

		// Loop through each checkbox
		for (let i = 0; i < checkboxes.length; i++) {
			// Type cast the element to HTMLInputElement
			let checkbox = checkboxes[i] as HTMLInputElement;

			// Check if the checkbox is checked
			if (checkbox.checked) {
				// Add the value of the checked checkbox to the selectedValues array
				ip_list.push(checkbox.value);
			}
		}

		// Now you have an array of the selected checkbox values
		console.log(ip_list);
		return ip_list;
	};
	onMount(() => {
		console.log('msg:', msg, msg.length);
	});
</script>

<div class="flex flex-col justify-evenly border w-full h-[73vh] p-1">
	<div class="border w-full h-[73vh] p-1">
		<div class="w-full border-2 border-b-black">
			<input
				type="button"
				value="SEND"
				class="border pl-2 pr-2 mr-5 bg-blue-600 text-white rounded-md"
				on:click={handleSend}
			/>
			<label for="old"
				><input type="checkbox" value="10.9.64.28" id="old" name="test_srv_list" checked /> 10.9.64.28</label
			>
			|
			<label for="new"
				><input type="checkbox" value="10.162.138.83" id="new" name="test_srv_list" checked /> 10.162.138.83</label
			>
		</div>
		{msg}
	</div>
	<div class="border w-full h-[73vh] p-1">left:</div>
	<div class="border w-full h-[73vh] p-1">right</div>
</div>
