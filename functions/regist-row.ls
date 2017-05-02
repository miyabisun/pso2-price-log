require! {
  moment
}

module.exports = (sheet, id, price, cb)-->
  err, [row] <- sheet.get-rows do
    offset: 1
    limit: 1
    query: "名称 = \"#id\""
  switch
  | err => cb err, null; return
  | row => cb {msg: "found id: #id"}, null; return
  | _ =>
    err <- sheet.add-row do
      \名称 : id
      \仕入値 : price
      \登録日時 : moment!.format "YYYY/MM/DD HH:mm"
    _, [row] <- sheet.get-rows do
      offset: 1
      limit: 1
      query: "名称 = \"#id\""
    cb err, row

