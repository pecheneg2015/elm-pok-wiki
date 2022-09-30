module Components.Slider.Types exposing (InternalMsg(..), Model, Msg(..), TranslationDictionary, Translator)


type Msg
    = ForSelf InternalMsg


type InternalMsg
    = Next
    | Prev
    | SetItems (List String)


type alias Model =
    { slides : List String
    , currentSlide : Int
    }


type alias TranslationDictionary msg =
    { onInternalMessage : InternalMsg -> msg
    }


type alias Translator msg =
    Msg -> msg
