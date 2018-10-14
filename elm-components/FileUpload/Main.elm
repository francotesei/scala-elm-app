module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, title, class, id, type_)
import Html.Events exposing (on)
import Json.Decode as JD
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
    }


init : ( Model, Cmd Msg )
init =
    ( { id = "FileInputId"
      , mFile = Nothing
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = FileSelected
    | FileRead FilePortData


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



---- VIEW ----


view : Model -> Html Msg
view model =
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
                (JD.succeed FileSelected)
            ]
            []
        , imagePreview
        ]


viewFilePreview : File -> Html Msg
viewFilePreview file =
    div
        []
        [ text file.contents , text file.filename]


subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead FileRead

