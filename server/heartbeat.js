const sendHeartbeat = async ({ playerCount }) => {
	const { data } = await axios.post(
		`${GetConvar('cad_API')}/servers/heartbeat`,
		{
			serverName: GetConvar('sv_projectName'),
			port: GetConvar('cad_server_port'),
			maxPlayers: GetConvar('sv_maxclients'),
			playerCount: playerCount,
		}
	);
};

on('adrenCAD:sendHearteat', sendHeartbeat);
