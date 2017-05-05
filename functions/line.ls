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

module.exports = (creds, line)-->
  particle = line |> parse
  if particle.target isnt \PARTY => return
  if particle.message is /\/init/ =>
    console.info "=> initialize!"
    <- do-initialize {status, particle, creds}
    <- do-refresh status
  if status.player-id isnt particle.player-id => return
  switch
  | particle.message is /\/exit/ =>
    console.info "=> exit!"
    reset status
  | particle.message is /\/regist/ =>
    console.info "=> regist!"
    status <<< mode: \regist
    console.info "start regist item mode."
  | particle.message is /\/stop/ =>
    console.info "=> stop!"
    status <<< mode: \update
    <- do-next status
    console.info "end regist item mode."
  | particle.message is /\/refresh/ =>
    console.info "=> refresh!"
    <- do-refresh status.sheet
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

