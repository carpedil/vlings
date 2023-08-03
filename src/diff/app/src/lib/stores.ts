import { writable } from 'svelte/store';

export let callback_msg1 = writable('');
export let callback_msg2 = writable('');
export let base_url = writable('');
export let ws_url = writable('');
export let remot_srv_addrs = writable<string[]>([]);
