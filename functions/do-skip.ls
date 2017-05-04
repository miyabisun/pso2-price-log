require! {
  \prelude-ls : {empty, last}
  \./parse.ls
  \./parse-num.ls
  \./update-row.ls
}

module.exports = (status, cb)->
  if empty status.rows => console.info "nothing items."; return
  last-row = status.rows |> last
  price = last-row.\相場 - /,/g
  err, new-row <- update-row status.sheet, last-row.\名称, price
  console.info "skip: #{last-row.\名称}"
  cb!

