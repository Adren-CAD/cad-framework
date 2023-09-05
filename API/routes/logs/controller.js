const createNewLog = (req, res) => {
	try {
		const { logs } = req.body;

		logs.forEach(({ log, error }) => {
			Logger.log(log, error);
		});
	} catch (err) {
		console.log(err);

		res.json({
			error: 'Unexpected error while trying too create logs.',
		});
	}
};
