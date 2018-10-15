module Api exposing (..)

import Json.Decode as Json
import Http exposing (..)
import Types exposing (File)
import Msgs exposing (..)


type  alias ApiResponse =
    { error : Maybe String
    , success : Maybe String
    }


buildRequest : Http.Body -> Request String
buildRequest b =
    Http.request
        { method = "POST"
        , headers = []
        , url = "/upload"
        , body = b
        , expect = expectJson decodeResponse
        , timeout = Nothing
        , withCredentials = False
        }


defaultRequestHeaders : List Header
defaultRequestHeaders =
    [ Http.header "Content-Type" "application/json"
    , Http.header "Content-Transfer-Encoding" "base64"
    ]



buildBody: File -> Http.Body
buildBody file =
    multipartBody
        [
         stringPart "filename"  file.filename
       , stringPart "content"  file.contents
        ]




decodeResponse : Json.Decoder String
decodeResponse =
    Json.at [ "response" ] Json.string

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

sendFile : File -> Cmd Msg
sendFile file =
    Http.send Send (buildRequest (buildBody file))