require! {
  \./parse.ls
}

module.exports = (text)->
  text |> parse |> (.target is \PARTY)

