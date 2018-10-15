module Main exposing (..)
import Models exposing (..)
import Updates exposing (..)
import Msgs exposing (..)
import Views exposing (..)
import Html exposing (..)
import Ports exposing (FilePortData, fileSelected, fileContentRead)
import Navigation
import Auth0.Actions exposing (..)
import Auth0.Commands exposing (gotoLogin)
import Ports exposing (..)

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
      , store = (checkStorage flags)
      }
    , checkAuth (checkStorage flags)
    )


checkStorage : Maybe (List StorageData) -> (List StorageData)
checkStorage mList =
    case mList of
        Just l ->
            l
        Nothing ->
            []


checkAuth : (List StorageData) -> Cmd Msg
checkAuth store =
    if(List.isEmpty store) then gotoLogin
    else Cmd.none


---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead FileRead


{-
 if( not (List.isEmpty (List.filter (\x -> x.key == "token" &&  not (String.isEmpty x.value)) store))) then gotoLogin
    else Cmd.none

-}