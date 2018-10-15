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

{-main : Program Never Model Msg
main =
    Navigation.program
        UrlChange
            { init = init
            , update = update
            , view = view
            , subscriptions = subscriptions
            }
-}

main : Program (Maybe (List Data)) Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


---- INIT MODEL ----

init : Maybe (List Data) -> Navigation.Location -> ( Model, Cmd Msg )
init flags location =
    ( { id = "FileInputId"
      , mFile = Nothing
      , response = { success = Nothing, error = Nothing}
      , auth = {token = "", action = CheckAuth}
      , page = Home
      }
    , check
    )




check: Cmd Msg
check =
    storePosts [{data1 = "hola"}]




---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead FileRead


