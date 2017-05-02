require("livescript");
var moment = require("moment");
var file_tail = require("file-tail");
var line = require("../functions/line.ls");

var path = [
  process.env.HOMEPATH,
  "\\Documents\\SEGA\\PHANTASYSTARONLINE2\\log\\ChatLog",
  moment().subtract(9, "hours").format("YYYYMMDD"),
  "_00.txt"
].join("");
console.log(path);
var ft = file_tail.startTailing({
  fd: path,
  encoding: "utf-16le"
});
var creds = require(process.env.HOMEPATH + "\\pso2.json");
ft.on("line", line(creds));

