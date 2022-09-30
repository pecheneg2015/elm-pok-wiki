module Main exposing (main)

import Browser
import Main.State exposing (init, update)
import Main.Types exposing (Model, Msg)
import Main.View exposing (view)


main : Program Int Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \m ->
                { title = "ElmPokemonWiki"
                , body = [ view m ]
                }
        , subscriptions = \_ -> Sub.none
        }
