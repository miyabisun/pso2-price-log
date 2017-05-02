require! {
  chai: {expect}
  \prelude-ls : {each, find, at, flip}
  \../../../functions/is-party.ls
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \PUBLIC ->
    "2017-05-02T18:01:02\t6565\tPUBLIC\t12345678\t安藤優\ttest"
    |> is-party >> expect >> (.to.be.ng)
  specify \PARTY ->
    "2017-05-02T18:01:02\t6565\tPARTY\t12345678\t安藤優\ttest"
    |> is-party >> expect >> (.to.be.ok)
  specify \GUILD ->
    "2017-05-02T18:01:02\t6565\tGUILD\t12345678\t安藤優\ttest"
    |> is-party >> expect >> (.to.be.ng)
  specify \chat_PARTY ->
    "2017-05-02T18:01:02\t6565\tGUILD\t12345678\t安藤優\tPARTY"
    |> is-party >> expect >> (.to.be.ng)

