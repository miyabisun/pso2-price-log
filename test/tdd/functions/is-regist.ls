require! {
  chai: {expect}
  \prelude-ls : {each, find, at, flip}
  \../../../functions/is-regist.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \normal ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\ttest"
    |> main >> expect >> (.to.be.ng)
  specify \regist ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\tregist"
    |> main >> expect >> (.to.be.ng)
  specify \/regist ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\t/regist"
    |> main >> expect >> (.to.be.ok)
  specify \/p_/regist ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\t/p /regist"
    |> main >> expect >> (.to.be.ok)
  specify \PUBLIC_and_/regist ->
    "2017-05-02T18:01:02\t6565\tPUBLIC\t12345678\t安藤優\t/regist"
    |> main >> expect >> (.to.be.ok)
  specify \GUILD_and_/regist ->
    "2017-05-02T18:01:02\t6565\tGUILD\t12345678\t安藤優\t/regist"
    |> main >> expect >> (.to.be.ok)

