require! {
  clipboardy
}

module.exports = (text)->
  clipboardy.write-sync text

