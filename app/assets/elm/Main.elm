module Main exposing (..)
import Models exposing (..)
import Updates exposing (..)
import Msgs exposing (..)
import Views exposing (..)
import Html exposing (..)
import Ports exposing (FilePortData, fileSelected, fileContentRead)
import Navigation
import Auth0.Actions exposing (..)
import Auth0.Commands exposing (manageAuth)
import Ports exposing (..)
import QueryString
import Routing exposing (..)

---- PROGRAM ----

main : Program (Maybe (List StorageData)) Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


---- INIT MODEL ----

init : Maybe (List StorageData) -> Navigation.Location -> ( Model, Cmd Msg )
init flags location =
    ( { id = "FileInputId"
      , mFile = Nothing
      , response = { success = Nothing, error = Nothing}
      , auth = {token = "", action = CheckAuth}
      , page = Loading
      , store = (transformStorage flags)
      }
    , manageAuth (transformStorage flags) location
    )


transformStorage : Maybe (List StorageData) -> (List StorageData)
transformStorage mList =
    case mList of
        Just list -> list
        Nothing -> []

---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead FileRead

