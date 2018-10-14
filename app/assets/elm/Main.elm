module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, title, class, id, type_,style,for)
import Html.Events exposing (on, onClick)
import Json.Decode as Json
import Http exposing (..)
import Json.Encode as Encode
import Ports exposing (FilePortData, fileSelected, fileContentRead)
import Utils exposing (File)
import Api exposing (..)

import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Button as Button
import Styles exposing (..)


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


type alias Model =
    { id : String
    , mFile : Maybe File
    , response : ApiResponse
    }


init : ( Model, Cmd Msg )
init =
    ( { id = "FileInputId"
      , mFile = Nothing
      , response = { success = Nothing, error = Nothing}
      }
    , Cmd.none
    )



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



---- VIEW ----


view : Model -> Html Msg
view model =
    Grid.container []
        [  CDN.stylesheet,
            Grid.row [ Row.centerLg ]
                [
                    Grid.col [ Col.md4 ] []


                ,   Grid.col [ Col.md4 ] [ viewInputFile model ]


                ,   Grid.col [ Col.md4 ] []
                ],
                br[][],
                Grid.row [ Row.centerLg ]
                                [
                                    Grid.col [ Col.md4 ] []


                                ,   Grid.col [ Col.md4 ] [ viewSendFile model ]


                                ,   Grid.col [ Col.md4 ] []
                                ]
    ]

viewSendFile : Model -> Html Msg
viewSendFile model =
    div []
    [  Button.button [ Button.secondary, Button.large, Button.block, Button.attrs [ onClick (SendFile model.mFile) ]] [ text "Enviar" ]
    , div [] [ text (Maybe.withDefault "" model.response.success) ]
     , div [] [ text (Maybe.withDefault "" model.response.error) ]
    ]


viewInputFile : Model -> Html Msg
viewInputFile model =
    div [ class "" ]
    [
         input
            [ type_ "file"
            , class ""
            , id model.id
            , on "change"
                (Json.succeed FileSelected)
            ]
            []

        ]

---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead FileRead


