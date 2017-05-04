require! {
  \prelude-ls : {last}
  \./parse.ls
  \./reset.ls
  \./sheet.ls : Sheet
  \./next-row.ls
}

module.exports = ({status, text, creds}, cb)->
  parsed = text |> parse
  [_, id, sheet-name] = parsed.message.match /\/init\s(\S+)\s(\S+)/
  unless id and sheet-name => return
  reset status
  err, sheet <- Sheet id, creds, sheet-name
  console.error that if err
  console.error "sheet is not found." unless sheet
  status <<< {sheet, parsed.player-id}
  cb!

