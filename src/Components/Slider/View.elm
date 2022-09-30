module Components.Slider.View exposing (view)

import Array
import Components.Slider.Types exposing (InternalMsg(..), Model, Msg(..))
import Html exposing (Html, button, div, img)
import Html.Attributes exposing (attribute, class, src)
import Html.Events exposing (onClick)


prevClickHandler : Msg
prevClickHandler =
    ForSelf Prev


nextClickHandler : Msg
nextClickHandler =
    ForSelf Next


getSlideValue : Model -> String
getSlideValue { slides, currentSlide } =
    let
        slideArray =
            Array.fromList slides

        slide =
            Array.get currentSlide slideArray
    in
    Maybe.withDefault "" slide


view : Model -> Html Msg
view model =
    div [ class "slider" ]
        [ button [ onClick prevClickHandler, class "slider__button  slider__button__left" ]
            [ img [ src "/static/images/left.svg", class "h-8 grow-o" ] []
            ]
        , div [ class "slider__slide" ]
            [ img [ class "h-full", src <| getSlideValue model, attribute "loading" "lazy" ] []
            ]
        , button [ onClick nextClickHandler, class "slider__button slider__button__right " ]
            [ img [ src "/static/images/right.svg", class "h-8 grow-o" ] []
            ]
        ]
