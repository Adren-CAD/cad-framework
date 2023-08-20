const chalk = require('chalk');
const moment = require('moment');

class Logger {
	static log(content, error) {
		const time = `[${moment().format('HH:mm:ss')}]`;

		const prefix = time + `[AdrenCAD]`;

		return console.log(
			`${prefix} ${(error ? chalk.red : chalk.green)(content)}`
		);
	}

	static error(content) {
		return this.log(content, 'error');
	}

	static warn(content) {
		return this.log(content, 'warn');
	}

	static debug(content) {
		return this.log(content, 'debug');
	}
}

on('adrenCAD:log', Logger.log);
