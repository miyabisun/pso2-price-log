require! {
  moment
}

module.exports = (status, cb)-->
  err, rows <- status.sheet.get-rows do
    offset: 1
    orderby: \更新日時
  console.error that if err
  status <<< {rows}
  cb!

