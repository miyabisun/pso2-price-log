require! {
  \prelude-ls : {empty, last}
  \./parse.ls
  \./parse-num.ls
  \./update-row.ls
}

module.exports = ({text, status}, cb)->
  if empty status.rows => console.info "nothing items."; return
  parsed = text |> parse
  price = parsed.message |> parse-num
  last-row = status.rows |> last
  err, new-row <- update-row status.sheet, last-row.\名称, price
  console.info "update: #{last-row.\名称} => #{price.to-locale-string!}"
  cb!

