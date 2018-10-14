module Api exposing (..)
import Json.Decode as Json
import Http exposing (..)
import Json.Encode as Encode
import Utils exposing (File)
import Html exposing (..)


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
        , expect = expectJson decodeCounter
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




decodeCounter : Json.Decoder String
decodeCounter =
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

