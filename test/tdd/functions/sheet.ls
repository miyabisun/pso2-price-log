require! {
  chai: {expect}
  moment
  \prelude-ls : {each, find}
  \../../../functions/sheet.ls : main
  \../../../configs/pso2.json : creds
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  params = {}
  before (done)!->
    @timeout 5_000ms
    err, info <- main "1kEbYw_LzArMwD5WWtF76N3vMF1N26X4jeMFbUaT8BHI", creds
    params <<< {err, info}
    done!
  specify \err_is_null ->
    params.err |> expect >> (.to.be.null)
  specify \info_is_ok ->
    params.info |> expect >> (.to.be.ok)

