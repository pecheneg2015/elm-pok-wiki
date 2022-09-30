module Components.Footer.Footer exposing (appFooter)

import Html exposing (Html, div, footer, p, text)
import Html.Attributes exposing (class)


appFooter : Html msg
appFooter =
    footer [ class "w-full fixed bottom-0 z-50 bg-white shadow-[0_35px_60px_-15px_rgba(0,0,0,0.5)] py-2" ]
        [ div [ class " max-w-5xl mx-auto  flex items-center justify-between space-x-4 h-8 px-2" ]
            [ p [ class "text-m" ] [ text "©2022-2022" ]
            , p [] [ text " Pokémon and Pokémon character names are trademarks of Nintendo." ]
            ]
        ]
