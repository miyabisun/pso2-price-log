require! {
  \prelude-ls : {last}
  \./next-row.ls
  \./to-clipboard.ls
}

module.exports = (status, cb)->
  err, row <- next-row status.sheet
  console.error that if err
  if row
    status.rows.push row
    last-row = status.rows |> last
    last-row.\名称 |> to-clipboard
    console.info "target: #{last-row.\名称} (#{last-row.\更新日時}) #{last-row.\相場}"
  else
    console.info "nothing items."

