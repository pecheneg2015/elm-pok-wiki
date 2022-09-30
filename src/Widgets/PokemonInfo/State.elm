module Widgets.PokemonInfo.State exposing (initState, sliderTranslator, translator, update)

import Components.Slider.State as SliderState
import Components.Slider.Types as SliderTypes
import Widgets.PokemonInfo.API exposing (fetchPosts)
import Widgets.PokemonInfo.Helpers exposing (fetchRespToPokemonInfo)
import Widgets.PokemonInfo.Types exposing (InternalMsg(..), MaybePokemonInfo, Model, Msg(..), TranslationDictionary, Translator)


initStateVal : Model
initStateVal =
    { link = Nothing
    , data = Nothing
    , slider = Tuple.first SliderState.initState
    }


initState : ( Model, Cmd Msg )
initState =
    ( initStateVal, Cmd.map sliderTranslator <| Tuple.second SliderState.initState )


sliderTranslator : SliderTypes.Translator Msg
sliderTranslator =
    SliderState.translator
        { onInternalMessage = ForSelf << SliderInnerMsg
        }


getSlides : MaybePokemonInfo -> List String
getSlides data =
    case data of
        Just item ->
            item.imageList

        Nothing ->
            []


translator : TranslationDictionary msg -> Translator msg
translator { onInternalMessage } msg =
    case msg of
        ForSelf internal ->
            onInternalMessage internal


update : InternalMsg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchPokemonInfo url ->
            ( { model | link = Just url }, fetchPosts url )

        OnServerResponse res ->
            case res of
                Ok r ->
                    let
                        data =
                            fetchRespToPokemonInfo r

                        ( childA, cmd ) =
                            SliderState.update (SliderTypes.SetItems <| getSlides data) model.slider
                    in
                    ( { model
                        | data = data
                        , slider = childA
                      }
                    , Cmd.map sliderTranslator cmd
                    )

                Err _ ->
                    ( model, Cmd.none )

        SliderInnerMsg internal ->
            let
                ( childA, cmd ) =
                    SliderState.update internal model.slider
            in
            ( { model | slider = childA }, Cmd.map sliderTranslator cmd )
