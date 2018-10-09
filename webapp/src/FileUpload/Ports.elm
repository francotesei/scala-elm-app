port module FileUpload.Ports exposing (FilePortData, fileContentRead, fileSelected)


type alias FilePortData =
    { contents : String
    , filename : String
    }


port fileSelected : String -> Cmd msg


port fileContentRead : (FilePortData -> msg) -> Sub msg
