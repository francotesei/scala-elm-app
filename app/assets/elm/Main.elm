module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, img, input, text, button )
import Html.Attributes exposing (class, id, src, title, type_)
import Html.Events exposing (on, onClick)
import Http
import Json.Decode as Json
import Ports exposing (FilePortData, fileContentRead, fileSelected)

import Json.Encode as Encode


---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }



---- MODEL ----


type alias File =
    { contents : String
    , filename : String
    }


type alias Model =
    { id : String
    , mFile : Maybe File
    , res : String
    , error : Maybe String
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
    | SendFile (Maybe File)


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

            SendFile  mFile ->
               ( model,sendFile mFile)
            Send (Ok r) ->
                ( { model | res = r, error = Nothing }, Cmd.none )

            Send (Err err) ->
                ( { model | error = Just <| httpErrorToString err }, Cmd.none )


---- VIEW ----


view : Model -> Html Msg
view model =
    div[]
    [renderButton model,viewFile model]





viewFilePreview : File -> Html Msg
viewFilePreview  file =
    div
        []
        [ text file.contents, text file.filename]



viewFile : Model -> Html Msg
viewFile model =
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



renderButton : Model -> Html Msg
renderButton model =
    div []
        [ button [ onClick (SendFile model.mFile) ] [ text "Enviar Archivo" ]
        , div [] [ text  model.res ]
        , div [] [ text (Maybe.withDefault "" model.error) ]
        ]





subscriptions : Model -> Sub Msg
subscriptions model =
    fileContentRead (SendFile model.mFile)




-- HTTP


sendFile : Maybe File -> Cmd Msg
sendFile mfile =
    case mfile of
        Just f ->
            Http.send Send (Http.post "/health2" (buildBody f ) decodeCounter)
        Nothing ->
            Http.send Send (Http.post "/health2" (buildBody ({filename="asd",contents=""}) ) decodeCounter)

httpErrorToString : Http.Error -> String
httpErrorToString err =
    case err of
        Http.BadUrl msg ->
            "BadUrl " ++ msg

        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "NetworkError"

        Http.BadStatus _ ->
            "BadStatus"

        Http.BadPayload msg _ ->
            "BadPayload " ++ msg




buildBody: File -> Http.Body
buildBody file =
    memberEncoded file |> Http.jsonBody

memberEncoded : File -> Encode.Value
memberEncoded file =

    let
        list =
            [ ( "fname", Encode.string file.filename )
          --  . "fcontents", Encode.string file.contents )
           ]
    in
        list
            |> Encode.object

decodeCounter : Json.Decoder String
decodeCounter =
    Json.at [ "counter" ] Json.string
