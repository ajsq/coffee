module Main exposing (main)

import Browser
import Floors exposing (..)
import FontAwesome.Icon as Icon
import FontAwesome.Solid as Icon
import Html
    exposing
        ( div
        , table
        , tbody
        , td
        , text
        , th
        , thead
        , tr
        )
import Html.Attributes exposing (class, colspan)
import Html.Events exposing (onClick)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy)
import Search exposing (SearchField)
import Tachyons exposing (classes)
import Tachyons.Classes as T


main : Program () Model Msg
main =
    Browser.document
        { view = docView
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : () -> ( Model, Cmd msg )
init _ =
    ( initModel, Cmd.none )


type alias Model =
    { floors : List Floor
    , sort : Sort
    , searchBy : SearchField
    }


type alias Sort =
    { option : SortOption
    , direction : SortDirection
    }


type SortOption
    = FloorNum
    | Espresso
    | Drip


type SortDirection
    = Up
    | Down


initModel : Model
initModel =
    { floors = floorList
    , sort = Sort FloorNum Up
    , searchBy = SearchField False ""
    }


type Msg
    = ToggleSort SortOption
    | SearchMsg Search.Msg


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ToggleSort sortOption ->
            if sortOption == model.sort.option then
                ( { model | sort = invertUpDownSort model.sort }, Cmd.none )

            else
                ( { model | sort = Sort sortOption Up }, Cmd.none )

        SearchMsg submsg ->
            ( { model
                | searchBy =
                    Search.update submsg model.searchBy
              }
            , Cmd.none
            )


docView : Model -> Browser.Document Msg
docView model =
    { title = "F5 Tower Coffee"
    , body = [ view model ]
    }


view : Model -> Html.Html Msg
view model =
    let
        displayFloors =
            sortedFloors model
                |> (if model.searchBy.enabled then
                        filterFloors model.searchBy.search

                    else
                        identity
                   )
    in
    div [ classes [ T.center, T.mw8, T.sans_serif ] ]
        [ div [ classes [ T.lh_title, T.f1, T.pl3 ] ] [ text "F5 Tower Coffee" ]
        , lazy Search.view model.searchBy |> Html.map SearchMsg
        , table
            [ classes [ T.pa2 ] ]
            [ lazy tableHeaders model.sort
            , lazy keyedFloorRows displayFloors
            ]
        ]


tableHeaders : Sort -> Html.Html Msg
tableHeaders sort =
    tr [ classes [ T.bg_lightest_blue ] ]
        [ th [ classes [ T.pa1 ] ] [ text "Floor", iconFor sort FloorNum ]
        , th [ classes [ T.pa1 ] ] [ text "Espresso", iconFor sort Espresso ]
        , th [ classes [ T.pa1 ] ] [ text "Drip", iconFor sort Drip ]
        ]


viewMachine : Machine -> Html.Html Msg
viewMachine machine =
    [ div
        [ classes
            [ T.fl
            , T.w_100
            , T.tc
            , T.fw6
            ]
        ]
        [ text machine.roaster ]
    , div
        [ classes [ T.fl, T.w_100, T.w_50_l, T.tc, T.bb, T.bn_l, T.pb1, T.pb0_l ] ]
        [ text machine.left ]
    , div
        [ classes [ T.fl, T.w_100, T.w_50_l, T.tc ] ]
        [ text machine.right ]
    ]
        |> td []


floorRow : Floor -> Html.Html Msg
floorRow floor =
    tr [ classes [ T.striped__light_gray, T.bg_near_white ] ]
        [ td [ classes [ T.tc ] ] [ text (String.fromInt floor.floor) ]
        , lazy viewMachine floor.espresso
        , lazy viewMachine floor.drip
        ]


keyedFloorRows : List Floor -> Html.Html Msg
keyedFloorRows list =
    List.map
        (\f ->
            ( f.floor |> String.fromInt, lazy floorRow f )
        )
        list
        |> Keyed.node "tbody" []


sortedFloors : Model -> List Floor
sortedFloors model =
    let
        transform =
            case model.sort.direction of
                Up ->
                    identity

                Down ->
                    List.reverse
    in
    case model.sort.option of
        FloorNum ->
            List.sortBy .floor model.floors
                |> transform

        Espresso ->
            List.sortBy (\a -> a.espresso.roaster) model.floors
                |> transform

        Drip ->
            List.sortBy (\a -> a.drip.roaster) model.floors
                |> transform


iconFor : Sort -> SortOption -> Html.Html Msg
iconFor sort option =
    Html.a [ classes [ T.pl2 ], onClick (ToggleSort option) ]
        [ if sort.option /= option then
            sortIcon

          else
            case sort.direction of
                Up ->
                    sortUpIcon

                Down ->
                    sortDownIcon
        ]


invertUpDown : SortDirection -> SortDirection
invertUpDown sortDirection =
    case sortDirection of
        Up ->
            Down

        Down ->
            Up


invertUpDownSort : Sort -> Sort
invertUpDownSort sort =
    { sort | direction = invertUpDown sort.direction }


sortIcon : Html.Html Msg
sortIcon =
    Icon.viewIcon Icon.sort


sortUpIcon : Html.Html Msg
sortUpIcon =
    Icon.viewIcon Icon.sortUp


sortDownIcon : Html.Html Msg
sortDownIcon =
    Icon.viewIcon Icon.sortDown


filterFloors : String -> List Floor -> List Floor
filterFloors search floors =
    List.filter
        (\a ->
            String.concat [ a.espresso.roaster, a.drip.roaster ]
                |> String.toLower
                |> String.contains (String.toLower search)
        )
        floors
