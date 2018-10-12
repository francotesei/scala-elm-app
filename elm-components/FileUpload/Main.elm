module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, img, input, text)
import Html.Attributes exposing (class, id, src, title, type_)
import Html.Events exposing (on)
import Json.Decode as JD
import Ports exposing (FilePortData, fileContentRead, fileSelected)


type alias File =
    { contents : String
    , filename : String
    }



---- MODEL ----


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

---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }


