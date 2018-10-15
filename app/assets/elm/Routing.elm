module Routing exposing (..)
import Navigation as Nav
import Msgs exposing (..)



type Page
    = Home
    | AuthCallback
    | Loading



goto : String -> Cmd Msg
goto url =
    Nav.load url

gotoHome: Cmd Msg
gotoHome =
    goto "http://localhost:9000#home"


refreshUrl : Cmd Msg
refreshUrl =
    Nav.reload

getPage : String -> Page
getPage hash =
    case hash of
        "#home" ->
            Home

        "#access_token" ->
            AuthCallback
        "loading" ->
            Loading
        _ ->
            Home