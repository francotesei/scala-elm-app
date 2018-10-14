module Models exposing (..)

import  Http
import Utils exposing (File)
import Api exposing (ApiResponse)
import Ports exposing (FilePortData)


---- MODEL ----


type alias Model =
    { id : String
    , mFile : Maybe File
    , response : ApiResponse
    }


type Msg
    = FileSelected
    | FileRead FilePortData
    | SendFile (Maybe File)
    | Send (Result Http.Error String)
    | GoTo