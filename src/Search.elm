module Search exposing (Msg(..), SearchField, update, view)

import Html exposing (Html, div, input, span, text)
import Html.Attributes exposing (checked, placeholder, type_, value)
import Html.Events exposing (onCheck, onInput)
import Tachyons exposing (classes)
import Tachyons.Classes as T


type alias SearchField =
    { enabled : Bool
    , search : String
    }


type Msg
    = Toggle Bool
    | Change String


update : Msg -> SearchField -> SearchField
update msg model =
    case msg of
        Toggle bool ->
            SearchField bool ""

        Change string ->
            { model | search = string }


view : SearchField -> Html.Html Msg
view model =
    div [ classes [ T.cf, T.pl2 ] ]
        ([ div [ classes [ T.fl ] ]
            [ input
                [ type_ "checkbox"
                , checked model.enabled
                , onCheck Toggle
                ]
                []
            , span [ classes [ T.pl1 ] ] [ text "Search Roasters" ]
            ]
         ]
            ++ (if model.enabled then
                    [ div [ classes [ T.fl, T.pl2 ] ]
                        [ input
                            [ type_ "text"
                            , placeholder "Search for?"
                            , value model.search
                            , onInput Change
                            ]
                            []
                        ]
                    ]

                else
                    []
               )
        )
