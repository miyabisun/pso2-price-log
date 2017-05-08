module.exports = (num)->
  unit = switch
    | num is /k$/i => 1_000
    | num is /m$/i => 1_000_000
    | _ => 1
  return (parse-float num) * unit |> parse-int

