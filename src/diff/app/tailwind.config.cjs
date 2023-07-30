/** @type {import('tailwindcss').Config}*/
const config = {
	darkMode: 'class',
	content: [
		'./src/**/*.{html,js,svelte,ts}',
		require('path').join('./src/**/*.{html,js,svelte,ts}')
	],
	theme: {
		extend: {}
	},
	plugins: []
};

module.exports = config;
