module Components.Slider.State exposing (initState, translator, update)

import Components.Slider.Types exposing (InternalMsg(..), Model, Msg(..), TranslationDictionary, Translator)


init : Model
init =
    { slides = []
    , currentSlide = 0
    }


initState : ( Model, Cmd Msg )
initState =
    ( init, Cmd.none )


translator : TranslationDictionary msg -> Translator msg
translator { onInternalMessage } msg =
    case msg of
        ForSelf internal ->
            onInternalMessage internal


update : InternalMsg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Next ->
            let
                isNotLast =
                    model.currentSlide < List.length model.slides - 1

                nextInd =
                    model.currentSlide + 1

                firstInd =
                    0

                nextSlide =
                    if isNotLast then
                        nextInd

                    else
                        firstInd
            in
            ( { model | currentSlide = nextSlide }, Cmd.none )

        Prev ->
            let
                isNotFirst =
                    model.currentSlide > 0

                prevInd =
                    model.currentSlide - 1

                lastInd =
                    List.length model.slides - 1

                prevSlide =
                    if isNotFirst then
                        prevInd

                    else
                        lastInd
            in
            ( { model | currentSlide = prevSlide }, Cmd.none )

        SetItems val ->
            ( { model | currentSlide = 0, slides = val }, Cmd.none )
