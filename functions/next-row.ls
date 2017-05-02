require! {
  moment
}

module.exports = (sheet, cb)-->
  err, [row] <- sheet.get-rows do
    offset: 1
    limit: 1
    query: '更新日時 = ""'
  switch
  | err => cb err, null
  | row => cb err, row
  | _ =>
    err, [row] <- sheet.get-rows do
      offset: 1
      limit: 1
      orderby: \更新日時
    switch
    | err or not row => cb err, null
    | moment(row.\更新日時, "YYYY/MM/DD HH:mm").is-after moment!.subtract(3, \days) => cb err, null
    | _ => cb err, row

