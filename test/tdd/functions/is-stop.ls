require! {
  chai: {expect}
  \prelude-ls : {each, find, at, flip}
  \../../../functions/is-stop.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \normal ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\ttest"
    |> main >> expect >> (.to.be.ng)
  specify \stop ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\tstop"
    |> main >> expect >> (.to.be.ng)
  specify \/stop ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\t/stop"
    |> main >> expect >> (.to.be.ok)
  specify \PUBLIC_and_/stop ->
    "2017-05-02T18:01:02\t6565\tPUBLIC\t12345678\t安藤優\t/stop"
    |> main >> expect >> (.to.be.ok)
  specify \GUILD_and_/stop ->
    "2017-05-02T18:01:02\t6565\tGUILD\t12345678\t安藤優\t/stop"
    |> main >> expect >> (.to.be.ok)

