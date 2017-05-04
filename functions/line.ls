require! {
  \./is-end.ls
  \./is-initialize.ls
  \./is-party.ls
  \./is-prev.ls
  \./is-regist.ls
  \./is-refresh.ls
  \./is-stop.ls
  \./is-skip.ls
  \./do-initialize.ls
  \./do-next.ls
  \./do-prev.ls
  \./do-skip.ls
  \./do-regist.ls
  \./do-update.ls
  \./reset.ls
  \./parse.ls
}
reset (status = {})

module.exports = (creds, text)-->
  parsed = text |> parse
  switch
  | text |> is-party |> (not) =>
    return
  | text |> is-initialize =>
    console.info "=> initialize!"
    <- do-initialize {status, text, creds}
    <- do-next status
  | status.player-id isnt parsed.player-id =>
    return
  | text |> is-end =>
    console.info "=> end!"
    reset status
  | text |> is-regist =>
    console.info "=> regist!"
    status <<< mode: \regist
    console.info "start regist item mode."
  | text |> is-stop =>
    console.info "=> stop!"
    status <<< mode: \update
    <- do-next status
    console.info "end regist item mode."
  | text |> is-refresh =>
    console.info "=> refresh!"
    status.rows.length = 0
    <- do-next status
  | text |> is-prev =>
    console.info "=> prev!"
    <- do-prev status
  | text |> is-skip =>
    console.info "=> skip!"
    <- do-skip status
    <- do-next status
  | status.mode is \regist =>
    console.info "=> regist item!"
    <- do-regist {text, status}
  | status.mode is \update =>
    console.info "=> update!"
    <- do-update {text, status}
    <- do-next status

