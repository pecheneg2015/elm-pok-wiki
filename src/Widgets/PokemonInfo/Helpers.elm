module Widgets.PokemonInfo.Helpers exposing (fetchRespToPokemonInfo)

import Round
import Widgets.PokemonInfo.APITypes exposing (FetchResp, StatResp)
import Widgets.PokemonInfo.Types exposing (MaybePokemonInfo, Stat)


statRespToStat : StatResp -> Stat
statRespToStat resp =
    { name = resp.stat.name, value = String.fromInt resp.base_stat }


stringIsNotEmpty : String -> Bool
stringIsNotEmpty val =
    String.length val > 0


useDefault : Maybe String -> String
useDefault val =
    Maybe.withDefault "" val


prepareSpriteList : List (Maybe String) -> List String
prepareSpriteList list =
    let
        filterEmpty =
            List.filter stringIsNotEmpty

        mapWithDefault =
            List.map useDefault
    in
    filterEmpty <| mapWithDefault list


prepareStatValue : Int -> String
prepareStatValue val =
    Round.round 2 <| 0.1 * toFloat val


fetchRespToPokemonInfo : FetchResp -> MaybePokemonInfo
fetchRespToPokemonInfo { name, height, weight, stats, sprites } =
    Just
        { name = name
        , height = prepareStatValue height
        , weight = prepareStatValue weight
        , stats = List.map statRespToStat stats
        , imageList = prepareSpriteList [ sprites.front_default, sprites.back_default, sprites.front_shiny, sprites.back_shiny, sprites.front_female, sprites.back_female, sprites.front_shiny_female, sprites.back_shiny_female ]
        }
