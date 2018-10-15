module Views exposing (..)
import Models exposing (..)
import Msgs exposing (..)


import Routing exposing (..)
import Html exposing (..)
import Html.Attributes exposing (src, title, class, id, type_,style,for)
import Html.Events exposing (on, onClick)
import Json.Decode as Json
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Button as Button
import Bootstrap.Alert as Alert


---- VIEW ----


view : Model -> Html Msg
view model =
    routesView model


routesView : Model -> Html Msg
routesView model =
    case model.page of
        Home -> homeView model

        Loading -> loadingView model

        _ -> homeView model



loadingView : Model -> Html Msg
loadingView model =
    div[][ text "cargando..." ]


homeView :Model -> Html Msg
homeView model =
    Grid.container []
        [  CDN.stylesheet, br [] [], br [] [], br [] [],
            Grid.row [ Row.centerLg ]
                [
                    Grid.col [ Col.md4 ] []


                ,   Grid.col [ Col.md4 ] [ viewInputFile model ]


                ,   Grid.col [ Col.md4 ] []
                ],
                br[][],
                Grid.row [ Row.centerLg ]
                                [
                                    Grid.col [ Col.md4 ] []


                                ,   Grid.col [ Col.md4 ] [ viewSendFile model ]


                                ,   Grid.col [ Col.md4 ] []
                                ]
    ]




viewSendFile : Model -> Html Msg
viewSendFile model =
    div []
    [  Button.button [ Button.secondary, Button.large, Button.block, Button.attrs [ onClick (SendFile model.mFile) ]] [ text "Enviar" ],
    Button.button [ Button.secondary, Button.large, Button.block, Button.attrs [ onClick Logout ]] [ text "Logout" ]
    , br [] []
    , div [] [ showRes model.response.success ]
     , div [] [ showError model.response.error ]
    ]

showRes : (Maybe String) -> Html Msg
showRes mRes =
    case mRes of
        Just r -> Alert.simplePrimary [] [text r]
        Nothing -> div [] []

showError : (Maybe String) -> Html Msg
showError mErr =
    case mErr of
        Just e -> Alert.simpleDanger [] [text e]
        Nothing -> div [] []


viewInputFile : Model -> Html Msg
viewInputFile model =
    div [ class "" ]
    [
         input
            [ type_ "file"
            , class ""
            , id model.id
            , on "change"
                (Json.succeed FileSelected)
            ]
            []

        ]


