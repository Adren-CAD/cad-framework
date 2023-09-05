const _axios = require('axios');

const axios = _axios.create();

axios.defaults.headers.common['Authorization'] = `Bearer ${GetConvar(
	'ADRENCAD_KEY'
)}`;
