require! {
  \prelude-ls : {head}
  \./get-rows.ls
}

module.exports = (status, cb)-->
  err, rows <- get-rows status.sheet
  console.error that if err
  status <<< {rows, pointer: 0}
  if empty status.rows
    console.info "nothing items."
    return
  row = status.rows |> head
  row.\名称 |> to-clipboard
  console.info "target: #{row.\名称} (#{row.\更新日時}) #{row.\相場}"
  cb!

