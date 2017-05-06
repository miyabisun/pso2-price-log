var flags = [];
var enclose = require("enclose").exec;

try {
  require.resolve("npm");
} catch (error) {
  console.log("Failed to require('npm')");
  console.log("Please run 'npm install' here");
  process.exit(1);
}

flags.push("--config", "./config.js");
flags.push("./windows.js");
enclose(flags);
