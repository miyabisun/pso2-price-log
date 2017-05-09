require! {
  chai: {expect}
  moment
  \prelude-ls : {each, find}
  \../../../functions/sheet.ls : main
  \../../config/pso2.json : creds
  \../../config/sheet.json : {id: sheet-id, name: sheet-name}
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  params = {}
  before (done)!->
    @timeout 5_000ms
    err, info <- main sheet-id, creds, sheet-name
    params <<< {err, info}
    done!
  specify \err_is_null ->
    params.err |> expect >> (.to.be.null)
  specify \info_is_ok ->
    params.info |> expect >> (.to.be.ok)

