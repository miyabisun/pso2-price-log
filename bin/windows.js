require("livescript");
var fs = require("fs");
var moment = require("moment");
var file_tail = require("file-tail");
var line = require("../functions/line.ls");

var path = [
  process.env.HOMEPATH,
  "\\Documents\\SEGA\\PHANTASYSTARONLINE2\\log\\ChatLog",
  moment().subtract(9, "hours").format("YYYYMMDD"),
  "_00.txt"
].join("");
var creds_path = [
  process.env.HOMEPATH,
  "\\pso2.json"
].join("");

console.info("required files path:", {ChatLog: path, Creds: creds_path});

try {
  var creds = JSON.parse(fs.readFileSync(creds_path).toString());
  var ft = file_tail.startTailing({
    fd: path,
    encoding: "utf-16le"
  });
  ft.on("line", line(creds));
  console.info("Get Ready.");
} catch (e) {
  console.error("not found files...");
}

