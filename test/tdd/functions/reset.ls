require! {
  chai: {expect}
  \prelude-ls : {each, find, at, flip}
  \../../../functions/reset.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  specify \normal ->
    main (status = {})
    status |> expect >> (.to.have.contain.keys <[sheet rows playerId mode all pointer]>)

