module Widgets.PokemonList.Types exposing (InternalMsg(..), Msg(..), OutMsg(..), PokemonLink, PokemonListInfo, TranslationDictionary, Translator)

import Http
import Widgets.PokemonList.APITypes exposing (PokemonListResp)


type alias PokemonListInfo =
    { links : List PokemonLink
    , offset : Int
    , pageSize : Int
    , count : Int
    }


type alias PokemonLink =
    { link : String
    , name : String
    }


type Msg
    = ForSelf InternalMsg
    | ForParent OutMsg


type OutMsg
    = SetSelectedPokemon String


type InternalMsg
    = FetchData Int Int
    | OnServerResponse Int (Result Http.Error PokemonListResp)


type alias TranslationDictionary msg =
    { onInternalMessage : InternalMsg -> msg
    , onSetLink : String -> msg
    }


type alias Translator msg =
    Msg -> msg
