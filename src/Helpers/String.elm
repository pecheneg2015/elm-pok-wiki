module Helpers.String exposing (capitalizeString)


capitalizeString : String -> String
capitalizeString initVal =
    let
        head =
            String.toUpper <| String.left 1 initVal

        body =
            String.dropLeft 1 initVal
    in
    head ++ body
