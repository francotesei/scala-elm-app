module Models exposing (..)

import Utils exposing (File)
import Api exposing (ApiResponse)


---- MODEL ----


type alias Model =
    { id : String
    , mFile : Maybe File
    , response : ApiResponse
    }


