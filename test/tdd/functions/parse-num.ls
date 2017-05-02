require! {
  chai: {expect}
  \prelude-ls : {each, find, at, flip}
  \../../../functions/parse-num.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \normal ->
    "12345"
    |> main >> expect >> (.to.equal 12345)
  specify \k ->
    "12345k"
    |> main >> expect >> (.to.equal 12345_000)
  specify \m ->
    "12345m"
    |> main >> expect >> (.to.equal 12345_000_000)
  specify \decimal ->
    "123.45"
    |> main >> expect >> (.to.equal 123)
  specify \decimal_k ->
    "123.45k"
    |> main >> expect >> (.to.equal 123_450)
  specify \decimal_m ->
    "123.45m"
    |> main >> expect >> (.to.equal 123_450_000)

