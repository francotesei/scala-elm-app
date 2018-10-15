module Auth0.Commands exposing (..)
import Navigation
import Msgs exposing (..)
import LocalStorage
import Ports exposing (StorageData)
import QueryString
import Routing exposing (..)
import Env exposing (..)





gotoLogin : Cmd Msg
gotoLogin =
    goto (auth0_domain_url ++ "/authorize?response_type=token&client_id=" ++ auth0_client_id ++ "&redirect_uri=" ++ auth0_callback_url)


gotoLogout : Cmd Msg
gotoLogout =
    goto (auth0_domain_url ++ "/logout?client_id=" ++ auth0_client_id ++ "&returnTo=" ++ auth0_return_url)


manageAuth : (List StorageData) -> Navigation.Location -> Cmd Msg
manageAuth store location =
    if(List.isEmpty store && not (String.contains "#access_token" location.hash)) then gotoLogin
    else
        let mToken = (QueryString.parse location.hash |> QueryString.one QueryString.string "#access_token")
        in case mToken of
            Just token -> Cmd.batch [ (LocalStorage.save [({key = "access_token", value = token})]), (gotoHome) ]
            Nothing -> Cmd.none
