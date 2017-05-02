require! {
  chai: {expect}
  \prelude-ls : {each, find, at, flip}
  \../../../functions/is-end.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \normal ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\ttest"
    |> main >> expect >> (.to.be.ng)
  specify \end ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\tend"
    |> main >> expect >> (.to.be.ng)
  specify \/end ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\t/end"
    |> main >> expect >> (.to.be.ok)
  specify \/p_/end ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\t/p /end"
    |> main >> expect >> (.to.be.ok)
  specify \PUBLIC_and_/end ->
    "2017-05-02T18:01:02\t6565\tPUBLIC\t12345678\t安藤優\t/end"
    |> main >> expect >> (.to.be.ok)
  specify \GUILD_and_/end ->
    "2017-05-02T18:01:02\t6565\tGUILD\t12345678\t安藤優\t/end"
    |> main >> expect >> (.to.be.ok)

