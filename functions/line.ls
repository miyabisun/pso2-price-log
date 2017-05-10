require! {
  \./do-initialize.ls
  \./do-refresh.ls
  \./do-next.ls
  \./do-prev.ls
  \./do-skip.ls
  \./do-add.ls
  \./do-update.ls
  \./reset.ls
  \./parse.ls
}
reset (status = {})

module.exports = (creds, line)-->
  particle = line |> parse
  if particle.target isnt \PARTY => return
  {message} = particle
  if message is /\/init\s/ =>
    console.info "=> initialize!"
    <- do-initialize {status, particle, creds}
    <- do-refresh status
  if status.player-id isnt particle.player-id => return
  switch
  | message is /\/all/ =>
    console.info "=> all!"
    status <<< {all: yes}
    <- do-refresh status
  | message is /\/select/ =>
    console.info "=> select!"
    status <<< {all: no}
    <- do-refresh status
  | message is /\/exit/ =>
    console.info "=> exit!"
    reset status
  | message is /\/regist/ =>
    console.info "=> regist!"
    status <<< mode: \regist
    console.info "start regist item mode."
  | message is /\/end/ =>
    console.info "=> end!"
    status <<< mode: \update
    <- do-refresh status
    console.info "end regist item mode."
  | message is /\/refresh/ =>
    console.info "=> refresh!"
    <- do-refresh status
  | message is /\/prev/ =>
    console.info "=> prev!"
    <- do-prev status
  | message is /\/skip/ =>
    console.info "=> skip!"
    <- do-skip status
    <- do-next status
  | message is /\/add\s/ =>
    console.info "=> add item!"
    particle.message = particle.message - /\/add\s/
    <- do-add {particle, status}
  | status.mode is \regist =>
    console.info "=> add item!"
    <- do-add {particle, status}
  | status.mode is \update and particle.message is /\d+[km]?$/i =>
    console.info "=> update!"
    <- do-update {particle, status}
    <- do-next status

