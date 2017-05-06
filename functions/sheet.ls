require! {
  \prelude-ls : {find}
  \./google-spreadsheet : GoogleSpreadsheet
}

module.exports = (id, creds, sheet-name, cb)->
  doc = new GoogleSpreadsheet id
  err <- doc.use-service-account-auth creds
  if err => cb err, null; return
  err, info <- doc.get-info
  if err => cb err, null; return
  info.worksheets
  |> (or [])
  |> find (.title is sheet-name)
  |> cb null, _

