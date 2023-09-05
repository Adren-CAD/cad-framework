function performHTTPDataRequest() {
	const API = GetConvar('cad_internal_API');

	return axios.get(`${API}/internal/community/loadscreen`, {
		headers: {
			Authorization: `Bearer ${GetConvar('ADRENCAD_KEY')}`,
		},
	});
}

const fetchLoadscreenData = async (req, res) => {
	try {
		const { data } = await performHTTPDataRequest();

		res.json(data);
	} catch (err) {
		console.log(err);

		res.json({
			error: 'Unexpected error while trying too fetch loadscreen data.',
		});
	}
};
