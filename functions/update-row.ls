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
  | not row => cb {msg: "not found id: #id"}, null; return
  | _ =>
    row <<<
      \相場 : price
      \更新日時 : moment!.format "YYYY/MM/DD HH:mm"
      \率 : price / (row.\仕入値 |> (- /,/g) |> parse-int)
    <- row.save
    cb null, row

