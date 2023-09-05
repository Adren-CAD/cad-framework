const AccountsAPI = express.Router();

AccountsAPI.post('/authencated', accountAuthencated);

AccountsAPI.post('/error', authencationError);

API.use('/accounts', AccountsAPI);
