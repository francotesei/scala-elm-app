module Models exposing (..)

import Utils exposing (File)
import Api exposing (ApiResponse)
import Ports exposing (FilePortData)
import AuthModel exposing (Auth)

---- MODEL ----


type alias Model =
    { id : String
    , mFile : Maybe File
    , response : ApiResponse
    , auth : Auth
    }

