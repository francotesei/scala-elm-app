module Auth0.Commands exposing (..)
import Navigation
import Msgs exposing (..)
import LocalStorage
import Ports exposing (StorageData)
import QueryString
import Routing exposing (..)






gotoLogin : Cmd Msg
gotoLogin =
    goto "https://redbee.auth0.com/authorize?response_type=token&client_id=BI0pcNiLJ3GhKSw2MY2diFBngY7chzHe&redirect_uri=http://localhost:9000/#authcallback"


gotoLogout : Cmd Msg
gotoLogout =
    goto "https://redbee.auth0.com/v2/logout?client_id=BI0pcNiLJ3GhKSw2MY2diFBngY7chzHe&returnTo=http://localhost:9000/#home"


manageAuth : (List StorageData) -> Navigation.Location -> Cmd Msg
manageAuth store location =
    if(List.isEmpty store && not (String.contains "#access_token" location.hash)) then gotoLogin
    else
        let mToken = (QueryString.parse location.hash |> QueryString.one QueryString.string "#access_token")
        in case mToken of
            Just token -> Cmd.batch [ (LocalStorage.save [({key = "access_token", value = token})]), (gotoHome) ]
            Nothing -> Cmd.none
