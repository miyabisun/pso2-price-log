require! {
  \prelude-ls : {at, last}
  \./to-clipboard.ls
}

module.exports = (status, cb)->
  if status.pointer is 0
    console.info "pointer is start."
  else
    row = status.pointer |> at status.rows
    row.\名称 |> to-clipboard
    console.info "target: #{row.\名称} (#{row.\更新日時}) #{row.\相場}"
  cb!

