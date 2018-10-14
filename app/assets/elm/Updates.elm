module Updates exposing (..)
import Models exposing (Model)

import Http exposing (..)
import Json.Encode as Encode
import Ports exposing (FilePortData, fileSelected, fileContentRead)
import Utils exposing (File)
import Api exposing (..)

---- UPDATE ----


type Msg
    = FileSelected
    | FileRead FilePortData
    | SendFile (Maybe File)
    | Send (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of

        FileSelected ->
            ( model
            , fileSelected model.id
            )

        FileRead data ->
            let
                newFile =
                    { contents = data.contents
                    , filename = data.filename
                    }
            in
            ( { model | mFile = Just newFile }
            , Cmd.none
            )
        Send (Ok r) ->
            ({ model | response = ({ success = Just <| toString r, error = Nothing }) }, Cmd.none)

        Send (Err e) ->
            ({ model   | response = ({ error = Just <| httpErrorToString e, success = Nothing }) }, Cmd.none)

        SendFile mFile ->
            case mFile of
                Just f ->
                    (model, sendFile f)
                Nothing ->
                    (model, Cmd.none)



sendFile : File -> Cmd Msg
sendFile file =
    Http.send Send (buildRequest (buildBody file))