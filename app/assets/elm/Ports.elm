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

port saveStorage : List StorageData -> Cmd msg

port clearStorage : String -> Cmd msg
