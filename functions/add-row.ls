require! {
  moment
}

module.exports = (sheet, id, price, cb)-->
  err, [row] <- sheet.get-rows do
    offset: 0
    limit: 1
    query: "名称 = \"#id\""
  switch
  | err => cb err, null; return
  | row => cb {msg: "found id: #id"}, null; return
  | _ =>
    err <- sheet.add-row do
      \名称 : id
      \仕入値 : price or 10000
      \登録日時 : moment!.format "YYYY/MM/DD HH:mm"
      \相場 : price
      \率 : unless price then "" else "100%"
      \更新日時 : unless price then "" else moment!.format "YYYY/MM/DD HH:mm"
    get-rows-err, [row] <- sheet.get-rows do
      offset: 1
      limit: 1
      query: "名称 = \"#id\""
    console.error that if get-rows-err
    cb err, row

