module Widgets.PokemonList.View exposing (view)

import Helpers.String exposing (capitalizeString)
import Html exposing (Html, button, div, p, text)
import Html.Attributes exposing (class, disabled)
import Html.Events exposing (onClick)
import List exposing (indexedMap)
import Widgets.PokemonList.Types exposing (InternalMsg(..), Msg(..), OutMsg(..), PokemonLink, PokemonListInfo)


getLinkButtonClassList : Bool -> String
getLinkButtonClassList isDisabled =
    if not isDisabled then
        "pokemonList__button__active"

    else
        "pokemonList__button__disabled"


drawLinkItem : Int -> Int -> PokemonLink -> Html Msg
drawLinkItem offset ind item =
    let
        linkClickHandler =
            ForParent <| SetSelectedPokemon item.link

        indexValue =
            String.fromInt <| 1 + ind + offset

        indexText =
            String.append indexValue "."

        description =
            capitalizeString item.name
    in
    button [ class "pokemonList__link", onClick linkClickHandler ]
        [ p [] [ text indexText ]
        , p [ class "truncate" ] [ text description ]
        ]


drawLinks : List PokemonLink -> Int -> List (Html Msg)
drawLinks items offset =
    let
        curryDrawLinkItem =
            drawLinkItem offset
    in
    indexedMap curryDrawLinkItem items


clickHandler : Int -> Int -> (Int -> Int -> Int) -> Msg
clickHandler pageSize offset act =
    let
        offsetValue =
            act offset pageSize

        internalMsg =
            FetchData pageSize offsetValue
    in
    ForSelf internalMsg


view : PokemonListInfo -> Html Msg
view model =
    let
        { pageSize, offset } =
            model

        click =
            clickHandler pageSize offset

        prevIsDisabled =
            model.offset <= 0

        prevClassList =
            getLinkButtonClassList prevIsDisabled

        prevClickHandler =
            click (-)

        nextIsDisabled =
            model.offset >= model.count

        nextClassList =
            getLinkButtonClassList nextIsDisabled

        nextClickHandler =
            click (+)
    in
    div [ class "pokemonList" ]
        [ div [ class "pokemonList__links-container" ] (drawLinks model.links model.offset)
        , div [ class "pokemonList__button-container" ]
            [ button
                [ disabled prevIsDisabled
                , class prevClassList
                , onClick prevClickHandler
                ]
                [ text "Prev" ]
            , button
                [ disabled nextIsDisabled
                , class nextClassList
                , onClick nextClickHandler
                ]
                [ text "Next" ]
            ]
        ]
