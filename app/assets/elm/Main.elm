module Main exposing (..)
import Models exposing (..)
import Updates exposing (..)
import Views exposing (..)
import Html exposing (..)
import Ports exposing (FilePortData, fileSelected, fileContentRead)



---- PROGRAM ----

main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


---- INIT MODEL ----

init : ( Model, Cmd Msg )
init =
    ( { id = "FileInputId"
      , mFile = Nothing
      , response = { success = Nothing, error = Nothing}
      }
    , Cmd.none
    )

---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead FileRead


