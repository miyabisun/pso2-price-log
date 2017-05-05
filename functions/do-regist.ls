require! {
  \./parse.ls
  \./parse-num.ls
  \./regist-row.ls
}

module.exports = ({status, particle}, cb)->
  switch
  | particle.message is /,/ =>
    [id, price] = particle.message.split \,
    price = price |> parse-num
  | _ =>
    id = particle.message
    price = ""
  console.info "regist start to", id, price
  err, target-row <- regist-row status.sheet, id, price
  console.error that if err
  if target-row
    status.rows.push target-row
    console.info "regist #{target-row.\名称} is successful."
  cb!

