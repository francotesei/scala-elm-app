module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, title, class, id, type_)
import Html.Events exposing (on, onClick)
import Json.Decode as Json
import Http

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

---- MODEL ----


type alias File =
    { contents : String
    , filename : String
    }


type alias Model =
    { id : String
    , mFile : Maybe File
    , error : Maybe String
    , res : String
    }


init : ( Model, Cmd Msg )
init =
    ( { id = "FileInputId"
      , mFile = Nothing
      , error = Nothing
      , res = ""
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = FileSelected
    | FileRead FilePortData
    | Send (Result Http.Error String)
    | SendFile


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
            ({model | res = toString r, error = Nothing }, Cmd.none)

        Send (Err e) ->
            ({model | error = Just <| toString e}, Cmd.none)

        SendFile ->
            (model, sendFile)




---- VIEW ----


view : Model -> Html Msg

view model =
    div[][
    viewInputFile model , viewSendFile model
    ]


viewSendFile : Model -> Html Msg
viewSendFile model =
    div []
    [ button [ onClick SendFile ] [ text "Send File" ]
     , div [] [ text (toString model.res) ]
     , div [] [ text (Maybe.withDefault "" model.error) ]
    ]


viewInputFile : Model -> Html Msg
viewInputFile model =
    let
        imagePreview =
            case model.mFile of
                Just f ->
                    viewFilePreview f

                Nothing ->
                    text ""
    in
    div [ class "imageWrapper" ]
        [ input
            [ type_ "file"
            , id model.id
            , on "change"
                (Json.succeed FileSelected)
            ]
            []
        , imagePreview
        ]


viewFilePreview : File -> Html Msg
viewFilePreview file =
    div
        []
        [ text file.contents , text file.filename]



---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead FileRead


---- HTTP ----

sendFile : Cmd Msg
sendFile =
    Http.send Send (Http.get "/health2" decodeCounter)


decodeCounter : Json.Decoder String
decodeCounter =
    Json.at [ "counter" ] Json.string