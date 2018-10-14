module Main exposing (..)
import Models exposing (..)
import Updates exposing (..)
import Msgs exposing (..)
import Views exposing (..)
import Html exposing (..)
import Ports exposing (FilePortData, fileSelected, fileContentRead)
import Navigation



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
      , auth = {token = ""}
      , page = Home
      }
    , Cmd.none
    )

---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead FileRead


