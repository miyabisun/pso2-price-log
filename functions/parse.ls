require! {
  moment
  \prelude-ls : {split, last}
}

module.exports = (text)->
  text
  |> split "\t"
  |> ([time, id, target, player-id, name, message])->
    {time: moment time} <<< {id, target, player-id, name, message}

