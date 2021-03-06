require! {
  \prelude-ls : {at}
  \./parse-num.ls
  \./update-row.ls
}

module.exports = ({particle, status}, cb)->
  unless (row = status.rows |> at status.pointer)
    console.info "item not found."
  else
    price = particle.message |> parse-num
    update-row status.sheet, row.\名称, price, (->)
    console.info "update: #{row.\名称} => #{price.to-locale-string \ja-JP, maximum-fraction-digits: 3}"
    cb!

