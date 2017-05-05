module.exports = (sheet, cb)->
  err, rows <- sheet.get-rows do
    offset: 1
    query: '更新日時 = ""'
  second-err, second-rows <- sheet.get-rows do
    offset: 1
    orderby: \更新日時
    query: '更新日時 <> ""'
  cb (err or second-err), ([] ++ rows ++ second-rows)

