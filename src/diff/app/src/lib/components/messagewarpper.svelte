<script lang="ts">
	import { onMount } from 'svelte';
	import { callback_msg1, callback_msg2, ws_url, remot_srv_addrs } from '$lib/stores';

	export let msg: string;
	let srv_ip_list: string[] = [];

	const handleSend = async () => {
		callback_msg1.set('');
		callback_msg2.set('');
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

		set_up_ws(srv_ip_list, msg);
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

	const set_up_ws = (ip_list: string[], msg: string) => {
		let socket = new WebSocket(`${$ws_url}`);
		socket.onopen = function (e) {
			console.log('[open] Connection established');
			console.log('Sending to server');
			console.log(`${ip_list.toString()}>${msg}`);
			socket.send(`${ip_list.toString()}>${msg}`);
		};

		socket.onmessage = function (event) {
			console.log(`[message] Data received from server: ${event.data}`);
			updateCallbackMsg(event.data);
		};

		// socket.onclose = function (event) {
		// 	if (event.wasClean) {
		// 		console.log(`[close] Connection closed cleanly, code=${event.code} reason=${event.reason}`);
		// 	} else {
		// 		// e.g. server process killed or network down
		// 		// event.code is usually 1006 in this case
		// 		console.log('[close] Connection died');
		// 	}
		// };

		socket.onerror = function (error) {
			console.log(`[error]${JSON.stringify(error, null, 4)}`);
		};
	};

	const updateCallbackMsg = (data: string) => {
		if (data.includes('10.162.138.83')) {
			callback_msg2.update((msg) => (msg = data));
		} else {
			callback_msg1.update((msg) => (msg = data));
		}
	};
	onMount(() => {
		console.log('msg:', msg, msg.length);
	});
</script>

<div class="flex flex-col justify-evenly border w-[54vw] h-[74vh] p-1">
	<div class="w-full bg-white border-2 border-b-black h-fit sticky top-0">
		<input
			type="button"
			value="SEND"
			class="border pl-2 pr-2 mr-5 bg-blue-600 text-white rounded-md"
			on:click={handleSend}
		/>
		{#each $remot_srv_addrs as srv_addr, index}
			<label for={`id_${index}`}
				><input
					type="checkbox"
					value={srv_addr}
					id={`id_${index}`}
					name="test_srv_list"
				/>{srv_addr}</label
			>
		{/each}
	</div>
	<div class="border w-full h-[24vh] overflow-y-scroll p-1">
		{msg}
	</div>
	<div class="border w-[54vw] h-[34vh] overflow-y-scroll p-1">{@html $callback_msg1}</div>
	<div class="border w-[54vw] h-[34vh] overflow-y-scroll p-1">{@html $callback_msg2}</div>
</div>
