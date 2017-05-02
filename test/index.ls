require! {
  fs, \recursive-readdir-sync
  \prelude-ls : {filter, reject, map, each}
}

[
  \tdd
  # \unit
  # \join
]
|> each (target)->
  recursive-readdir-sync "./test/#target"
  |> filter (is /\.ls$/)
  |> each (.replace /^test/, \.) >> require

