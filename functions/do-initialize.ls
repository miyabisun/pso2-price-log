require! {
  \prelude-ls : {last}
  \./parse.ls
  \./reset.ls
  \./sheet.ls : Sheet
  \./next-row.ls
}

module.exports = ({status, particle, creds}, cb)->
  [_, id, sheet-name] = particle.message.match /\/init\s(\S+)\s(\S+)/
  unless id and sheet-name => return
  reset status
  err, sheet <- Sheet id, creds, sheet-name
  console.error that if err
  console.error "sheet is not found." unless sheet
  status <<< {sheet, particle.player-id}
  cb!

