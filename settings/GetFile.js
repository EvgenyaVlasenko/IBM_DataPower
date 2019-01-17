//Проверка существования запрашиваемого файла секретной информации или файла настроек и его возврат.
var fs = require('fs');
var sm = require ('service-metadata');

sm.setVar('var://service/mpgw/skip-backside', true);

var uri = sm.getVar ('var://service/URI');

var split = uri.indexOf("?");
if (split >= 0){
	uri = uri.substring(0, split);
}

var name = 'local://' + uri;

fs.exists (name, function(exists) {
	if(exists) {
		fs.readFile (name, function(error, buffer) {
			if(error) {
				throw error;
			}
			session.output.write(buffer.toString());
		}); 
	}
});
