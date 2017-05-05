require! {
  \prelude-ls : {at}
  \./update-row.ls
}

module.exports = (status, cb)->
  unless (row = status.rows |> at status.pointer)
    console.info "item not found."
  else
    price = row.\相場 - /,/g
    update-row status.sheet, row.\名称, price, (->)
    console.info "skip: #{row.\名称}"
    cb!

