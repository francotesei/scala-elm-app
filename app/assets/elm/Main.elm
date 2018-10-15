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

main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = (\_ -> init)
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


---- INIT MODEL ----

init : ( Model, Cmd Msg )
init =
    ( { id = "FileInputId"
      , mFile = Nothing
      , response = { success = Nothing, error = Nothing}
      , auth = {token = "", action = CheckAuth}
      , page = Home
      }
    , Cmd.none
    )


check: Cmd Msg
check =
    gotoLogin




---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead FileRead


