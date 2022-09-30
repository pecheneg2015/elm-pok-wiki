module Components.Header.Header exposing (appHeader)

import Html exposing (Html, a, div, h1, header, img, text)
import Html.Attributes exposing (class, href, src)


appHeader : Html msg
appHeader =
    header [ class "header" ]
        [ div [ class "header__content" ]
            [ a [ href "/" ] [ img [ src "/static/images/logo.png", class "header__logo" ] [] ]
            , h1 [ class "header__title" ] [ text "ElmPokemonWiki" ]
            ]
        ]
