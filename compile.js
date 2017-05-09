var flags = [];
var enclose = require("enclose").exec;

flags.push("--config", "./config.js");
flags.push("--output", "./tmp/pso2-price-log.exe");
flags.push("./windows.js");
enclose(flags);
