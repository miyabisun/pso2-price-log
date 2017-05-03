require! {
  chai: {expect}
  moment
  \prelude-ls : {each, find, at, flip}
  \../../../functions/regist-row.ls : main
  \../../../functions/sheet.ls : Spreadsheet
  \../../../configs/pso2.json : creds
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  params = {}
  before (done)!->
    @timeout 5_000ms
    sheet_err, sheet <- Spreadsheet "1kEbYw_LzArMwD5WWtF76N3vMF1N26X4jeMFbUaT8BHI", creds
    err, row <- main sheet, \test, 5000
    params <<< {sheet, err, row}
    done!
  specify \err_is_null ->
    params.err |> expect >> (.to.be.null)
  specify \row_is_ok ->
    params.row |> expect >> (.to.be.ok)
  specify \row_datum_is_valid ->
    params.row |> expect >> (.to.have.contain.keys <[名称 相場 更新日時]>)
  specify \row_delete (done)!->
    params.row.del done

