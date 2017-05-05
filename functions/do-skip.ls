require! {
  \./update-row.ls
}

module.exports = (status, cb)->
  unless (row = status.pointer |> at status.rows)
    console.info "item not found."
  else
    price = row.\相場 - /,/g
    update-row status.sheet, row.\名称, price, (->)
    console.info "skip: #{row.\名称}"
    cb!

