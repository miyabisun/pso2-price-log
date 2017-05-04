require! {
  chai: {expect}
  \prelude-ls : {each, find, at, flip}
  \../../../functions/is-prev.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \normal ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\ttest"
    |> main >> expect >> (.to.be.ng)
  specify \prev ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\tprev"
    |> main >> expect >> (.to.be.ng)
  specify \/prev ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\t/prev"
    |> main >> expect >> (.to.be.ok)
  specify \/p_/prev ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\t/p /prev"
    |> main >> expect >> (.to.be.ok)
  specify \PUBLIC_and_/prev ->
    "2017-05-02T18:01:02\t6565\tPUBLIC\t12345678\t安藤優\t/prev"
    |> main >> expect >> (.to.be.ok)
  specify \GUILD_and_/prev ->
    "2017-05-02T18:01:02\t6565\tGUILD\t12345678\t安藤優\t/prev"
    |> main >> expect >> (.to.be.ok)

