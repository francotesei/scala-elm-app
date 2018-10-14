module Auth exposing (..)

import Navigation as Nav
import Models exposing (..)

goto : String -> Cmd Msg
goto url =
    Nav.load url