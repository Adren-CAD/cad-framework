const API = express();

const port = GetConvar('cad_API_port') || 4005;

API.use(cors());

API.use(bodyParser.json());

API.get('/', (req, res) => res.sendStatus(200));

API.listen(port, () => Logger.log(`API Started on Port ${port}.`));
