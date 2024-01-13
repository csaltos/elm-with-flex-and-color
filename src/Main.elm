module Main exposing (..)

import Browser
import Html
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


type alias Model =
    { greeting : String
    , isVisible : Bool
    , color : String
    , size : Int
    }


type Msg
    = MsgChangeColor String
    | MsgChangeSize Int
    | MsgToggleVisibility


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


init : Model
init =
    { greeting = "Hola", isVisible = True, color = "black", size = 18 }


view : Model -> Html.Html Msg
view model =
    Html.div
        [ style "padding" "3em"
        , style "display" "flex"
        , style "flex-direction" "column"
        ]
        [ viewGreeting model.isVisible model.color model.size model.greeting
        , viewActionButtons model.isVisible
        ]


viewGreeting : Bool -> String -> Int -> String -> Html.Html msg
viewGreeting isVisible color size greeting =
    Html.div
        [ style "padding" "3em"
        , style "display" "flex"
        , style "justify-content" "space-around"
        ]
        (if isVisible then
            [ Html.div
                [ style "color" color
                , style "font-size" (String.fromInt size ++ "px")
                ]
                [ Html.text greeting
                ]
            ]

         else
            []
        )


viewActionButtons : Bool -> Html.Html Msg
viewActionButtons isVisible =
    Html.div
        [ style "padding" "3em"
        , style "display" "flex"
        , style "flex-direction" "column"
        ]
        [ viewVisibilityButton isVisible
        , viewColorButtons
        , viewSizeButtons
        ]


viewColorButtons : Html.Html Msg
viewColorButtons =
    Html.div
        [ style "padding" "3em"
        , style "display" "flex"
        , style "justify-content" "space-around"
        ]
        [ Html.button [ onClick (MsgChangeColor "red") ] [ Html.text "Red" ]
        , Html.button [ onClick (MsgChangeColor "blue") ] [ Html.text "Blue" ]
        , Html.button [ onClick (MsgChangeColor "yellow") ] [ Html.text "Yellow" ]
        , Html.button [ onClick (MsgChangeColor "orange") ] [ Html.text "Orange" ]
        ]


viewVisibilityButton : Bool -> Html.Html Msg
viewVisibilityButton isVisible =
    Html.div
        [ style "padding" "3em"
        , style "display" "flex"
        , style "justify-content" "space-around"
        ]
        [ if isVisible then
            Html.button [ onClick MsgToggleVisibility ] [ Html.text "Hide" ]

          else
            Html.button [ onClick MsgToggleVisibility ] [ Html.text "Show" ]
        ]


viewSizeButtons : Html.Html Msg
viewSizeButtons =
    Html.div
        [ style "padding" "3em"
        , style "display" "flex"
        , style "justify-content" "space-around"
        ]
        [ Html.button [ onClick (MsgChangeSize 8) ] [ Html.text "Small" ]
        , Html.button [ onClick (MsgChangeSize 18) ] [ Html.text "Normal" ]
        , Html.button [ onClick (MsgChangeSize 72) ] [ Html.text "Big" ]
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        MsgChangeColor color ->
            { model | color = color }

        MsgChangeSize size ->
            { model | size = size }

        MsgToggleVisibility ->
            { model | isVisible = not model.isVisible }
