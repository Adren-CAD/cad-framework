const LogsAPI = express.Router();

LogsAPI.post('/create', createNewLog);

API.use('/logs', LogsAPI);
