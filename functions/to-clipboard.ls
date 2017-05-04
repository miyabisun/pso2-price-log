require! {
  child_process: {exec}
}

module.exports = (text)->
  <- exec "SET /p DUMMY=\"#text\"<nul | clip"

