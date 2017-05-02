require! {
  chai: {expect}
  \prelude-ls : {each, find, at, flip}
  \../../../functions/is-next.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \normal ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\ttest"
    |> main >> expect >> (.to.be.ng)
  specify \next ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\tnext"
    |> main >> expect >> (.to.be.ng)
  specify \/next ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\t/next"
    |> main >> expect >> (.to.be.ok)
  specify \/p_/next ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\t/p /next"
    |> main >> expect >> (.to.be.ok)
  specify \PUBLIC_and_/next ->
    "2017-05-02T18:01:02\t6565\tPUBLIC\t12345678\t安藤優\t/next"
    |> main >> expect >> (.to.be.ok)
  specify \GUILD_and_/next ->
    "2017-05-02T18:01:02\t6565\tGUILD\t12345678\t安藤優\t/next"
    |> main >> expect >> (.to.be.ok)

