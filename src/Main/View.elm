module Main.View exposing (view)

import Components.Footer.Footer exposing (appFooter)
import Components.Header.Header exposing (appHeader)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Main.State exposing (childTranslator, pokemonInfoTranslator)
import Main.Types exposing (Model, Msg)
import Widgets.PokemonInfo.View as PokemonInfoView
import Widgets.PokemonList.View as PokemonListView


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ appHeader
        , div [ class "main__content" ]
            [ div [ class "main__list" ] [ Html.map childTranslator <| PokemonListView.view model.pokemonList ]
            , div [ class "main__info" ] [ Html.map pokemonInfoTranslator <| PokemonInfoView.view model.pokemonInfo ]
            ]
        , appFooter
        ]
