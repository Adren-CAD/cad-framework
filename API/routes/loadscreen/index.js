const LoadscreenAPI = express.Router();

LoadscreenAPI.get('/', fetchLoadscreenData);

API.use('/loadscreen', LoadscreenAPI);
