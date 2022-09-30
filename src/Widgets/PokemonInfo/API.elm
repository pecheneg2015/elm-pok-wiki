module Widgets.PokemonInfo.API exposing (fetchPosts)

import Http
import Json.Decode exposing (Decoder, field, list, map2, map5, map8)
import Widgets.PokemonInfo.APITypes exposing (FetchResp, SpritesResp, StatDescResp, StatResp)
import Widgets.PokemonInfo.Types exposing (InternalMsg(..), Msg(..))


fetchPosts : String -> Cmd Msg
fetchPosts url =
    Http.get
        { url = url
        , expect = Http.expectJson (ForSelf << OnServerResponse) dataDecoder
        }


spritesDecoder : Decoder SpritesResp
spritesDecoder =
    map8 SpritesResp
        (field "front_default" (Json.Decode.maybe Json.Decode.string))
        (field "back_default" (Json.Decode.maybe Json.Decode.string))
        (field "front_shiny" (Json.Decode.maybe Json.Decode.string))
        (field "back_shiny" (Json.Decode.maybe Json.Decode.string))
        (field "front_female" (Json.Decode.maybe Json.Decode.string))
        (field "back_female" (Json.Decode.maybe Json.Decode.string))
        (field "front_shiny_female" (Json.Decode.maybe Json.Decode.string))
        (field "back_shiny_female" (Json.Decode.maybe Json.Decode.string))


statDescDecoder : Decoder StatDescResp
statDescDecoder =
    map2 StatDescResp
        (field "name" Json.Decode.string)
        (field "url" Json.Decode.string)


statDecoder : Decoder StatResp
statDecoder =
    map2 StatResp
        (field "base_stat" Json.Decode.int)
        (field "stat" statDescDecoder)


dataDecoder : Decoder FetchResp
dataDecoder =
    map5 FetchResp
        (field "name" Json.Decode.string)
        (field "height" Json.Decode.int)
        (field "weight" Json.Decode.int)
        (field "stats" (list statDecoder))
        (field "sprites" spritesDecoder)
