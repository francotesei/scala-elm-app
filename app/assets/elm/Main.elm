module Main exposing (..)
import Models exposing (..)
import Updates exposing (..)
import Msgs exposing (..)
import Views exposing (..)
import Html exposing (..)
import Ports exposing (FilePortData, fileSelected, fileContentRead)
import Navigation
import Auth0.Actions exposing (..)
import Auth0.Commands exposing (gotoLogin,goto)
import Ports exposing (..)
import QueryString

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
      , page = Home
      , store = (transformStorage flags)
      }
    , checkAuth (transformStorage flags) location
    )


transformStorage : Maybe (List StorageData) -> (List StorageData)
transformStorage mList =
    case mList of
        Just list -> list
        Nothing -> []


checkAuth : (List StorageData) -> Navigation.Location -> Cmd Msg
checkAuth store location =
    if(List.isEmpty store && not (String.contains "#access_token" location.hash)) then gotoLogin
    else
        let mToken = (QueryString.parse location.hash |> QueryString.one QueryString.string "#access_token")
        in case mToken of
            Just token -> Cmd.batch [ (elmStore [({key = "access_token", value = token})]), (goto "http://localhost:9000#home") ]
            Nothing -> Cmd.none

---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead FileRead

