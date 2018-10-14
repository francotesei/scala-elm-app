module Auth exposing (..)

import Navigation as Nav
import Models exposing (..)

goto : String -> Cmd Msg
goto url =
    Nav.load url



gotoauth0 : Cmd Msg
gotoauth0 =
    goto "https://redbee.auth0.com/authorize?response_type=token&client_id=BI0pcNiLJ3GhKSw2MY2diFBngY7chzHe&redirect_uri=http://localhost:9000"

