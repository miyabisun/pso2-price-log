require! {
  \prelude-ls : {at, last}
  \./to-clipboard.ls
}

module.exports = (status, cb)->
  if status.pointer >= status.rows.length
    console.info "pointer is end."
  else
    status.pointer++
    row = status.rows |> at status.pointer
    row.\名称 |> to-clipboard
    console.info "target: #{row.\名称} (#{row.\更新日時}) #{row.\相場 or row.\仕入値}"
  cb!

