require! {
  chai: {expect}
  \prelude-ls : {each, find, at, flip}
  \../../../functions/reset.ls : main
}

filename = __filename.replace(/^.*(test)/, \test)
describe.only filename, ->
  specify \normal ->
    reset (status = {})
    |> console.log

