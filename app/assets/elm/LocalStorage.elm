module LocalStorage exposing (..)
import Ports exposing (StorageData,saveStorage,clearStorage)


save : List StorageData -> Cmd msg
save list =
    saveStorage list


delete : String -> Cmd msg
delete key =
    clearStorage key
