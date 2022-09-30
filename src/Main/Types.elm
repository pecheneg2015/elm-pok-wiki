module Main.Types exposing (Model, Msg(..))

import Widgets.PokemonInfo.Types as PokemonInfoTypes
import Widgets.PokemonList.Types as PokemonListTypes


type alias Model =
    { pokemonList : PokemonListTypes.PokemonListInfo
    , pokemonInfo : PokemonInfoTypes.Model
    , test : String
    }


type Msg
    = PokemonListInnerMsg PokemonListTypes.InternalMsg
    | SetLinkValue String
    | PokemonInfoInnerMsg PokemonInfoTypes.InternalMsg
