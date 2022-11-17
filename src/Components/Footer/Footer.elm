module Components.Footer.Footer exposing (appFooter)

import Html exposing (Html, div, footer, p, text)
import Html.Attributes exposing (class)


appFooter : Html msg
appFooter =
    footer [ class "footer" ]
        [ div [ class "footer__content" ]
            [ p [ class "text-m" ] [ text "©2022-2022" ]
            , p [class "text-center text-black/75 mt-4 md:mt-0"] [ text " Pokémon and Pokémon character names are trademarks of Nintendo." ]
            ]
        ]
