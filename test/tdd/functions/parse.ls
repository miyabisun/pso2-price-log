require! {
  chai: {expect}
  \prelude-ls : {each, find, at, flip}
  \../../../functions/parse.ls
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \PUBLIC ->
    "2017-05-02T18:01:02\t6565\tPUBLIC\t12345678\t安藤優\ttest"
    |> parse >> expect >> (.to.have.contain.keys <[time id target playerId name message]>)

