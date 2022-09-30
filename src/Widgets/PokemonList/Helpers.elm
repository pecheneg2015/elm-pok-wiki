module Widgets.PokemonList.Helpers exposing (parsePokemonListInfo)

import Widgets.PokemonList.APITypes exposing (PokemonLinkAPI, PokemonListResp)
import Widgets.PokemonList.Types exposing (PokemonLink, PokemonListInfo)


itemToPokemonLink : PokemonLinkAPI -> PokemonLink
itemToPokemonLink { url, name } =
    { link = url, name = name }


parsePokemonListInfo : Int -> Int -> PokemonListResp -> PokemonListInfo
parsePokemonListInfo offset pageSize apiResp =
    let
        { count, results } =
            apiResp

        links =
            List.map itemToPokemonLink results
    in
    { offset = offset
    , count = count
    , links = links
    , pageSize = pageSize
    }
