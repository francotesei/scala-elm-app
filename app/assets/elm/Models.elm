module Models exposing (..)

import Utils exposing (File)
import Api exposing (ApiResponse)
import Ports exposing (FilePortData,StorageData)
import Auth0.Models exposing (Auth)


---- MODEL ----

type Page
    = Home
    | About
    | Contact



type alias Model =
    { id : String
    , mFile : Maybe File
    , response : ApiResponse
    , auth : Auth
    , page : Page
    , store : (List StorageData)
     }

