module Widgets.PokemonInfo.APITypes exposing (FetchResp, SpritesResp, StatDescResp, StatResp)


type alias StatDescResp =
    { name : String
    , url : String
    }


type alias SpritesResp =
    { front_default : Maybe String
    , back_default : Maybe String
    , front_shiny : Maybe String
    , back_shiny : Maybe String
    , front_female : Maybe String
    , back_female : Maybe String
    , front_shiny_female : Maybe String
    , back_shiny_female : Maybe String
    }


type alias StatResp =
    { base_stat : Int
    , stat : StatDescResp
    }


type alias FetchResp =
    { name : String
    , height : Int
    , weight : Int
    , stats : List StatResp
    , sprites : SpritesResp
    }
