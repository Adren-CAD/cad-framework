let Config = null;
let ConfigSet = false;

onNet('adrenCAD:fetchConfig', () => {
	const player = source;

	if (ConfigSet && Config) {
		emitNet('adrenCAD:setConfig', player, Config);
	}
});

function setConfig(config) {
	emit('adrenCAD:configSet');

	SetConvar('cad_communityId', `${config.communityId}`);

	Config = config;

	ConfigSet = true;
}

const init = async () => {
	try {
		Logger.log('Verifying with AdrenCAD.');

		const InternalAPI = GetConvar('cad_API');

		const { data } = await axios.post(
			`${InternalAPI}/plugins/framework/setup`,
			{
				framework: true,
				version: GetConvar('cad_framework_version'),
				integrations: integrations,
			}
		);

		setConfig(data.config);
	} catch (err) {
		console.log(err);

		Logger.error('Error connecting.');
	}
};

init();
