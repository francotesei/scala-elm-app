module Msgs exposing (..)

import  Http
import Utils exposing (File)
import Ports exposing (FilePortData)
import AuthModel exposing (Auth)


type Msg
    = FileSelected
    | FileRead FilePortData
    | SendFile (Maybe File)
    | Send (Result Http.Error String)
    | CheckAuth Auth
    | AuthLogin