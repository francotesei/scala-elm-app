port module Ports exposing (..)


type alias FilePortData =
    { contents : String
    , filename : String
    }

type alias StorageData =
    { key : String
    , value : String
    }



port fileSelected : String -> Cmd msg

port fileContentRead : (FilePortData -> msg) -> Sub msg

port elmStore : List StorageData -> Cmd msg

