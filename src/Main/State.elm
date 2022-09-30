module Main.State exposing (childTranslator, init, pokemonInfoTranslator, update)

import Main.Types exposing (Model, Msg(..))
import Widgets.PokemonInfo.State as PokemonInfoState
import Widgets.PokemonInfo.Types as PokemonInfoTypes
import Widgets.PokemonList.State as PokemonListState
import Widgets.PokemonList.Types as PokemonListTypes


init : Int -> ( Model, Cmd Msg )
init _ =
    let
        ( pokemonListInit, pokemonListCommands ) =
            PokemonListState.initState

        ( pokemonInfoInit, pokemonInfoCommands ) =
            PokemonInfoState.initState
    in
    ( { pokemonList = pokemonListInit
      , pokemonInfo = pokemonInfoInit
      , test = ""
      }
    , Cmd.batch [ Cmd.map childTranslator pokemonListCommands, Cmd.map pokemonInfoTranslator pokemonInfoCommands ]
    )


childTranslator : PokemonListTypes.Translator Msg
childTranslator =
    PokemonListState.translator
        { onInternalMessage = PokemonListInnerMsg
        , onSetLink = SetLinkValue
        }


pokemonInfoTranslator : PokemonInfoTypes.Translator Msg
pokemonInfoTranslator =
    PokemonInfoState.translator
        { onInternalMessage = PokemonInfoInnerMsg
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        PokemonListInnerMsg internal ->
            let
                ( childA, cmd ) =
                    PokemonListState.update internal model.pokemonList
            in
            ( { model | pokemonList = childA }, Cmd.map childTranslator cmd )

        SetLinkValue val ->
            let
                ( childA, cmd ) =
                    PokemonInfoState.update (PokemonInfoTypes.FetchPokemonInfo val) model.pokemonInfo
            in
            ( { model | pokemonInfo = childA, test = val }, Cmd.map pokemonInfoTranslator cmd )

        PokemonInfoInnerMsg internal ->
            let
                ( childA, cmd ) =
                    PokemonInfoState.update internal model.pokemonInfo
            in
            ( { model | pokemonInfo = childA }, Cmd.map pokemonInfoTranslator cmd )
