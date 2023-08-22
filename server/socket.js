// const SDK = require('@adrencad/sdk');

const io = require('socket.io-client');

let Config = null;
let ConfigSet = false;

let _connection;

function setConfig(config) {
	emit('adrenCAD:configSet');

	SetConvar('cad_communityId', `${config.communityId}`);

	// SetConvar('cad_economy_enabled', JSON.stringify(config.economyEnabled));

	Config = config;

	ConfigSet = true;
}

on('adrenCAD:triggerSocket', (e, params) => {
	if (_connection) {
		_connection.emit(e, params);
	}
});

onNet('adrenCAD:fetchConfig', () => {
	const player = source;

	if (ConfigSet) {
		emitNet('adrenCAD:setConfig', player, Config);
	}
});

const init = async () => {
	try {
		Logger.log('Verifying with AdrenCAD.');

		// const API = new SDK({
		// 	framework: true,
		// 	version: Version,
		// 	dev: true,
		// });

		// const connection = await API.createConnection(APIKey);

		const connection = io('https://plugins-api.adrencad.com', {
			extraHeaders: {
				APIKey: GetConvar('ADRENCAD_KEY'),
			},
		});

		connection.emit('setup', {
			framework: true,
			version: GetConvar('cad_framework_version'),
			// dev: true,
		});

		_connection = connection;

		connection.on('log', Logger.log);

		connection.on('setConfig', setConfig);

		connection.on('account-authencated', ({ identifier, data }) => {
			const { token } = data;

			emit('adrenCAD:accountAuthencated', {
				identifier,
				token,
			});
		});

		connection.on('account-auth-error', ({ identifier }) => {
			emit('adrenCAD:accountError', {
				identifier,
			});
		});
	} catch (err) {
		console.log(err);

		Logger.error('error connecting.');
	}
};

init();
