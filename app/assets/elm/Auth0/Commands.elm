module Auth0.Commands exposing (..)

import Navigation as Nav
import Msgs exposing (..)



goto : String -> Cmd Msg
goto url =
    Nav.load url


gotoLogin : Cmd Msg
gotoLogin =
    goto "https://redbee.auth0.com/authorize?response_type=token&client_id=BI0pcNiLJ3GhKSw2MY2diFBngY7chzHe&redirect_uri=http://localhost:9000"

