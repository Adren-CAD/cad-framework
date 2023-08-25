let plugins = [];

const axios = require('axios');

on('adrenCAD:registerPlugin', async (plugin, data) => {
	let newPlugin = false;

	const { verify, newPlugin: _newPlugin } = data;

	if (_newPlugin) newPlugin = true;
	else if (verify) {
		const API = GetConvar('cad_API');

		const API_Key = GetConvar('ADRENCAD_KEY');

		const { data } = await axios.post(
			`${API}/plugins/fetch`,
			{ plugin: plugin },
			{ headers: { Authorization: `Bearer ${API_Key}` } }
		);

		newPlugin = data.new;
	}

	const pluginName = plugin.charAt(0).toUpperCase() + plugin.slice(1);

	plugins.push(plugin);

	if (newPlugin) {
		Logger.log(
			'This is the first time setting up this plugin, we will now begin the setup process!'
		);

		Logger.log(
			`The ${pluginName} plugin has been registered. You can now edit the plugin on your community settings dashboard.`
		);
	} else {
		Logger.log(`${pluginName} script started.`);
	}
});
