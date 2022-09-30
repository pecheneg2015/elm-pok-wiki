module Widgets.PokemonList.API exposing (fetchPosts)

import Http exposing (Error)
import Json.Decode exposing (Decoder, field, int, list, map2)
import Url.Builder exposing (crossOrigin, string)
import Widgets.PokemonList.APITypes exposing (PokemonLinkAPI, PokemonListResp)


itemDecoder : Decoder PokemonLinkAPI
itemDecoder =
    map2 PokemonLinkAPI
        (field "url" Json.Decode.string)
        (field "name" Json.Decode.string)


dataDecoder : Decoder PokemonListResp
dataDecoder =
    map2 PokemonListResp
        (field "results" (list itemDecoder))
        (field "count" int)


fetchPosts : (Result Error PokemonListResp -> msg) -> Int -> Int -> Cmd msg
fetchPosts callBack pageSize offset =
    let
        offsetString =
            String.fromInt offset

        limitString =
            String.fromInt pageSize

        url =
            crossOrigin "https://pokeapi.co/api/v2" [ "pokemon" ] [ string "offset" offsetString, string "limit" limitString ]
    in
    Http.get
        { url = url
        , expect = Http.expectJson callBack dataDecoder
        }
