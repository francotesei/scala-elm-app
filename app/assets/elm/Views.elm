module Views exposing (..)
import Models exposing (..)
import Msgs exposing (..)



import Html exposing (..)
import Html.Attributes exposing (src, title, class, id, type_,style,for)
import Html.Events exposing (on, onClick)
import Json.Decode as Json
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Button as Button

---- VIEW ----


view : Model -> Html Msg
view model =
    Grid.container []
        [  CDN.stylesheet,
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


                                ,   Grid.col [ Col.md4 ] [contentNavigation model]
                                ]
    ]

viewSendFile : Model -> Html Msg
viewSendFile model =
    div []
    [  Button.button [ Button.secondary, Button.large, Button.block, Button.attrs [ onClick (SendFile model.mFile) ]] [ text "Enviar" ] --onClick (SendFile model.mFile)
    , div [] [ text (Maybe.withDefault "" model.response.success) ]
     , div [] [ text (Maybe.withDefault "" model.response.error) ]
    ]


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


contentNavigation: Model ->  Msg
contentNavigation model =
    (AuthManager model.auth)
