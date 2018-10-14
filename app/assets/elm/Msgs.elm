module Msgs exposing (..)

import  Http
import Utils exposing (File)
import Ports exposing (FilePortData)
import Auth0.Models exposing (Auth)


type Msg
    = FileSelected
    | FileRead FilePortData
    | SendFile (Maybe File)
    | Send (Result Http.Error String)
    | CheckAuth Auth
    | AuthLogin