module Widgets.PokemonInfo.View exposing (view)

import Components.Slider.View as SliderView
import Helpers.String exposing (capitalizeString)
import Html exposing (Html, div, h5, p, text)
import Html.Attributes exposing (class)
import Widgets.PokemonInfo.State exposing (sliderTranslator)
import Widgets.PokemonInfo.Types exposing (Model, Msg, Stat)


drawStat : Stat -> Html msg
drawStat stat =
    let
        value =
            String.replace "-" " " <| capitalizeString <| stat.name ++ ":"
    in
    div [ class "pokemon-info__stat" ]
        [ p [ class "pokemon-info__stat-name" ] [ text value ]
        , p [ class "pokemon-info__stat-value" ] [ text stat.value ]
        ]


drawStats : List Stat -> List (Html msg)
drawStats stats =
    List.map drawStat stats


drawPokemonInfo : Model -> Html Msg
drawPokemonInfo model =
    case model.data of
        Nothing ->
            text ""

        Just info ->
            let
                title =
                    capitalizeString info.name

                fullStatList =
                    [ { name = "weight (kg)", value = info.weight }, { name = "height (m)", value = info.height } ] ++ info.stats
            in
            div [ class "pokemon-info__container" ]
                [ div [ class "pokemon-info__card" ]
                    [ Html.map sliderTranslator (SliderView.view model.slider)
                    , div [ class "pokemon-info__desc-container" ]
                        [ h5 [ class "pokemon-info__title" ] [ text title ]
                        , div [ class "pokemon-info__stat-list" ] (drawStats fullStatList)
                        ]
                    ]
                ]


view : Model -> Html Msg
view model =
    div []
        [ drawPokemonInfo model
        ]
