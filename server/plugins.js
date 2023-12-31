let plugins = [];

on('adrenCAD:registerPlugin', async (plugin, data) => {
	let newPlugin = false;

	const { verify, newPlugin: _newPlugin } = data;

	if (_newPlugin) newPlugin = true;
	else if (verify) {
		const _API = GetConvar('cad_API');

		const API_Key = GetConvar('ADRENCAD_KEY');

		const { data } = await axios.post(
			`${_API}/plugins/fetch`,
			{ plugin: plugin },
			{
				headers: {
					Authorization: `Bearer ${'kTLRTsl0EBqWB37UP63/YAc3x.tuWd+8XyeUgGj-Yq'}`,
				},
			}
		);

		newPlugin = data.new;
	}

	plugins.push(plugin);

	if (newPlugin) {
		Logger.log(
			'This is the first time setting up this plugin, we will now begin the setup process!'
		);

		Logger.log(
			`The ${plugin} plugin has been registered. You can now edit the plugin on your community settings dashboard.`
		);
	} else {
		Logger.log(`${plugin} script started.`);
	}
});
