/*global JSLINT*/
var home = environment.HOME;
var body = null;
var file = null;
var globalarguments = arguments;

function getFile() {
	if ( globalarguments.length < 1 ) {
		print('Argument length must be greater than 0. You must specify code to be checked.');
		return false;
	}

	body = globalarguments[0];

	if ( !home || !body ) {
		print('A HOME and file must be specified');
		return false;
	}

	file = home + '/src/js/fulljslint.js';
	return file;
}

file = getFile();

if ( file ) {
  load(file);

  var result = JSLINT(body, { browser: true, eqeqeq: true });
  if (result === true) {
    print("No issues found\n");
  } else {
    print("Problems found\n");
    errorCount = JSLINT.errors.length;
    for (i = 0; i < errorCount; i += 1) {
      error = JSLINT.errors[i];
      if (error && error.reason && error.reason.match(/^Stopping/) === null) {
	print([error.line, error.character, error.reason].join(":"));
      }
    }
  }
}
