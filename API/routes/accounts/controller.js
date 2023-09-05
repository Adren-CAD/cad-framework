const accountAuthencated = (req, res) => {
	try {
		const { identifier, data } = req.body;

		const { token } = data;

		emit('adrenCAD:accountAuthencated', {
			identifier,
			token,
		});

		res.json({
			message: 'Account authencated.',
		});
	} catch (err) {
		console.log(err);

		res.json({
			error: 'Unexpected error while trying too authencate account.',
		});
	}
};

const authencationError = (req, res) => {
	try {
		const { identifier } = req.body;

		emit('adrenCAD:accountError', {
			identifier,
		});
	} catch (err) {
		console.log(err);

		res.json({
			error: 'Unexpected error while trying too authencate account.',
		});
	}
};
