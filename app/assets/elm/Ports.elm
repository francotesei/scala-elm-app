port module Ports exposing (..)


type alias FilePortData =
    { contents : String
    , filename : String
    }


port fileSelected : String -> Cmd msg


port fileContentRead : (FilePortData -> msg) -> Sub msg

port storePosts : List Data -> Cmd msg

type alias Data =
    { data1 : String

    }