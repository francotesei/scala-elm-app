module Models exposing (..)

import Utils exposing (File)
import Api exposing (ApiResponse)
import Ports exposing (FilePortData,StorageData)
import Auth0.Models exposing (Auth)
import Routing exposing (Page)

---- MODEL ----


type alias Model =
    { id : String
    , mFile : Maybe File
    , response : ApiResponse
    , auth : Auth
    , page : Page
    , store : (List StorageData)
     }

