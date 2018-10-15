module Auth0.Models exposing (..)
import Auth0.Actions exposing (AuthAction)


type  alias Auth =
    { token : String
    , action : AuthAction
     }
