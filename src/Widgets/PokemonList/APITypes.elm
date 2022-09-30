module Widgets.PokemonList.APITypes exposing (PokemonLinkAPI, PokemonListResp)


type alias PokemonListResp =
    { results : List PokemonLinkAPI
    , count : Int
    }


type alias PokemonLinkAPI =
    { url : String
    , name : String
    }
