module Widgets.PokemonList.State exposing (initState, translator, update)

import Widgets.PokemonList.API exposing (fetchPosts)
import Widgets.PokemonList.Helpers exposing (parsePokemonListInfo)
import Widgets.PokemonList.Types exposing (InternalMsg(..), Msg(..), OutMsg(..), PokemonListInfo, TranslationDictionary, Translator)


initStateVal : PokemonListInfo
initStateVal =
    { links = []
    , offset = 0
    , pageSize = 10
    , count = 1000
    }


getListPage : Int -> Int -> Cmd Msg
getListPage pageSize offset =
    let
        callback =
            ForSelf << OnServerResponse offset
    in
    fetchPosts callback pageSize offset


initState : ( PokemonListInfo, Cmd Msg )
initState =
    ( initStateVal, getListPage initStateVal.pageSize initStateVal.offset )


translator : TranslationDictionary msg -> Translator msg
translator { onInternalMessage, onSetLink } msg =
    case msg of
        ForSelf internal ->
            onInternalMessage internal

        ForParent (SetSelectedPokemon val) ->
            onSetLink val


update : InternalMsg -> PokemonListInfo -> ( PokemonListInfo, Cmd Msg )
update msg model =
    case msg of
        FetchData pageSize offset ->
            ( model, getListPage pageSize offset )

        OnServerResponse offset res ->
            case res of
                Ok r ->
                    ( parsePokemonListInfo offset model.pageSize r, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )
