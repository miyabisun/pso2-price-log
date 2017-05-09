require! {
  chai: {expect}
  moment
  \prelude-ls : {each, find, at, flip}
  \../../../functions/get-rows.ls : main
  \../../../functions/sheet.ls : Spreadsheet
  \../../config/pso2.json : creds
  \../../config/sheet.json : {id: sheet-id, name: sheet-name}
}

filename = __filename.replace(/^.*(test)/, \test)
describe filename, ->
  params = {}
  before (done)!->
    @timeout 5_000ms
    _, sheet <- Spreadsheet sheet-id, creds, sheet-name
    no-err, no-rows <- main sheet, no
    yes-err, yes-rows <- main sheet, no
    params <<< {sheet, no-err, no-rows, yes-err, yes-rows}
    done!
  describe \no ->
    specify \err_is_null ->
      params.no-err |> expect >> (.to.be.null)
    specify \rows_is_ok ->
      params.no-rows |> expect >> (.to.be.an \array)
    specify \rows_datum_is_valid ->
      params.no-rows |> each expect >> (.to.have.contain.keys <[名称 相場 更新日時]>)
  describe \yes ->
    specify \err_is_null ->
      params.yes-err |> expect >> (.to.be.null)
    specify \rows_is_ok ->
      params.yes-rows |> expect >> (.to.be.an \array)
    specify \rows_datum_is_valid ->
      params.yes-rows |> each expect >> (.to.have.contain.keys <[名称 相場 更新日時]>)

