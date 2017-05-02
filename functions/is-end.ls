require! {
  \./parse.ls
}

module.exports = (text)->
  text |> parse |> (.message is /\/end/) |> Boolean

