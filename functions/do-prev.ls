require! {
  \prelude-ls : {empty, last}
  \./to-clipboard.ls
}

module.exports = (status, cb)->
  status.rows.pop!
  if empty status.rows
    console.info "item is nothing."
  else
    last-row = status.rows |> last
    last-row.\名称 |> to-clipboard
    console.info "target: #{last-row.\名称} #{last-row.\相場}"
  cb!

