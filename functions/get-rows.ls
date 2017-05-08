module.exports = (sheet, is-all,  cb)->
  query = unless is-all then " and 更新 = 1" else ""
  err, rows <- sheet.get-rows do
    offset: 1
    query: '更新日時 = ""' + query
  second-err, second-rows <- sheet.get-rows do
    offset: 1
    orderby: \更新日時
    query: '更新日時 <> ""' + query
  cb (err or second-err), ([] ++ rows ++ second-rows)

