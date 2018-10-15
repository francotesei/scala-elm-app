module Updates exposing (..)
import Models exposing (..)

import Http exposing (..)
import Ports exposing (FilePortData, fileSelected, fileContentRead,clearStorage)
import Utils exposing (File)
import Api exposing (..)
import Models exposing (..)
import Auth0.Commands exposing (..)
import Auth0.Models exposing (Auth)
import Msgs exposing (..)



---- UPDATE ----

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
        case msg of
            UrlChange location ->
                { model | page = (getPage location.hash) } ! [ Cmd.none ]

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

            AuthManager auth ->
                if String.isEmpty auth.token then (model, gotoLogin) else (model ,Cmd.none)

            Logout -> (model,Cmd.batch [ (clearStorage "all"), (gotoLogout)])




getPage : String -> Page
getPage hash =
    case hash of
        "#home" ->
            Home

        "#access_token" ->
            AuthCallback
        "loading" ->
            Loading
        _ ->
            Home


sendFile : File -> Cmd Msg
sendFile file =
    Http.send Send (buildRequest (buildBody file))

