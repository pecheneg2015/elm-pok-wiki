module Widgets.PokemonInfo.Types exposing (InternalMsg(..), MaybePokemonInfo, Model, Msg(..), Stat, TranslationDictionary, Translator)

import Components.Slider.Types as SliderTypes
import Http
import Widgets.PokemonInfo.APITypes exposing (FetchResp)


type alias MaybePokemonInfo =
    Maybe PokemonInfo


type alias PokemonInfo =
    { name : String
    , height : String
    , weight : String
    , imageList : List String
    , stats : List Stat
    }


type alias Stat =
    { name : String
    , value : String
    }


type alias Model =
    { slider : SliderTypes.Model
    , data : MaybePokemonInfo
    , link : Maybe String
    }


type Msg
    = ForSelf InternalMsg


type InternalMsg
    = SliderInnerMsg SliderTypes.InternalMsg
    | FetchPokemonInfo String
    | OnServerResponse (Result Http.Error FetchResp)


type alias TranslationDictionary msg =
    { onInternalMessage : InternalMsg -> msg
    }


type alias Translator msg =
    Msg -> msg
