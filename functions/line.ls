require! {
  moment, \file-tail
  \./is-end.ls
  \./is-initialize.ls
  \./is-next.ls
  \./is-party.ls
  \./is-regist.ls
  \./is-stop.ls
  \./sheet.ls : Sheet
  \./next-row.ls
  \./regist-row.ls
  \./update-row.ls
  \./to-clipboard.ls
  \./parse.ls
  \./parse-num.ls
}
status =
  sheet: null
  row: null
  player-id: null
  mode: \update

module.exports = (creds, text)-->
  parsed = text |> parse
  unless text |> is-party => return
  switch
  | text |> is-initialize =>
    console.info "=> initialize!"
    id = parsed.message - /^.*\/init /
    unless id => return
    err, sheet <- Sheet id, creds
    err, row <- next-row sheet
    status <<< {sheet, row, parsed.player-id}
    console.info "Get Ready."
  | text |> is-end =>
    if status.player-id isnt parsed.player-id => return
    console.info "=> end!"
    status <<<
      sheet: null
      row: null
      player-id: null
      mode: \update
  | text |> is-regist =>
    if status.player-id isnt parsed.player-id => return
    console.info "=> regist!"
    status <<< mode: \regist
    console.info "start register mode."
  | text |> is-stop =>
    if status.player-id isnt parsed.player-id => return
    console.info "=> stop!"
    status <<< mode: \update
    console.info "end register mode."
  | text |> is-next =>
    if status.player-id isnt parsed.player-id => return
    console.info "=> next!"
    unless status.sheet => return console.info "now loading..."
    unless status.row => return console.info "all item checked!"
    status.row.\名称 |> to-clipboard
    console.info "#{status.row.\名称} copied."
  | status.mode is \update =>
    if status.player-id isnt parsed.player-id => return
    console.info "=> update!"
    unless status.sheet => return
    price = parsed.message |> parse-num
    err, target-row <- update-row status.sheet, status.row.\名称, price
    err, row <- next-row status.sheet
    status <<< {row}
    console.info "update #{target-row.\名称} is successful."
  | status.mode is \regist =>
    if status.player-id isnt parsed.player-id => return
    console.info "=> regist item!"
    switch
    | parsed.message isnt /,/ =>
      id = parsed.message
      err, target-row <- regist-row status.sheet, id, ""
      console.error that if err
      if target-row
        status.row = target-row
        console.info "regist #{target-row.\名称} is successful."
    | _ =>
      id = parsed.message |> (is /([^,]*),/) |> (.1)
      price = parsed.message |> (is /,(.*)/) |> (.1) |> parse-num
      err, target-row <- regist-row status.sheet, id, price
      console.error that if err
      if target-row
        status.row = target-row
        console.info "regist #{target-row.\名称} is successful."

