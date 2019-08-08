module Main exposing (main)

import Browser
import Floors exposing (..)
import FontAwesome.Icon as Icon
import FontAwesome.Solid as Icon
import FontAwesome.Styles exposing (css)
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
    , sortOption : SortOption
    , sortDirection : SortDirection
    , searchBy : SearchField
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
    , sortOption = FloorNum
    , sortDirection = Up
    , searchBy = SearchField False ""
    }


type Msg
    = ToggleSort SortOption
    | SearchMsg Search.Msg


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ToggleSort sortOption ->
            if sortOption == model.sortOption then
                ( { model | sortDirection = invertUpDown model.sortDirection }, Cmd.none )

            else
                ( { model | sortOption = sortOption, sortDirection = Up }, Cmd.none )

        SearchMsg submsg ->
            ( { model
                | searchBy =
                    Search.update submsg model.searchBy
              }
            , Cmd.none
            )


docView : Model -> Browser.Document Msg
docView model =
    { title = "main"
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
        , Search.view model.searchBy |> Html.map SearchMsg
        , table
            [ classes [ T.pa2 ] ]
            ([ tr [ classes [ T.striped__light_gray ] ] (tableHeaders model) ]
                ++ List.map floorRow displayFloors
            )
        , css
        ]


tableHeaders : Model -> List (Html.Html Msg)
tableHeaders model =
    [ th [ classes [ T.pa1 ] ] [ text "Floor", iconFor model FloorNum ]
    , th [ classes [ T.pa1 ] ] [ text "Espresso", iconFor model Espresso ]
    , th [ classes [ T.pa1 ] ] [ text "Drip", iconFor model Drip ]
    ]


viewMachine : Machine -> List (Html.Html Msg)
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
        [ classes [ T.fl, T.w_50, T.tc ] ]
        [ text machine.left ]
    , div
        [ classes [ T.fl, T.w_50, T.tc ] ]
        [ text machine.right ]
    ]


floorRow : Floor -> Html.Html Msg
floorRow floor =
    tr [ classes [ T.striped__light_gray ] ]
        [ td [ classes [ T.tc ] ] [ text (String.fromInt floor.floor) ]
        , td [] (viewMachine floor.espresso)
        , td [] (viewMachine floor.drip)
        ]


floorList : List Floor
floorList =
    [ Floor 35
        (Machine "Fidalgo" "Islands Espresso" "Decaf Espresso")
        (Machine "Stumptown" "House Blend" "else")
    , Floor 34
        (Machine "Cafe Vita" "Theo Blend" "Novacella Decaf")
        (Machine "One Cup" "Queen City" "Decaf Republic of Cascadia")
    , Floor 41
        (Machine "Caffe Umbria" "Arco Etrusco" "Mezzanotte Blend")
        (Machine "Peet's" "House Blend" "Decaf House Blend")
    ]


sortedFloors : Model -> List Floor
sortedFloors model =
    let
        transform =
            case model.sortDirection of
                Up ->
                    identity

                Down ->
                    List.reverse
    in
    case model.sortOption of
        FloorNum ->
            List.sortBy .floor model.floors
                |> transform

        Espresso ->
            List.sortBy (\a -> a.espresso.roaster) model.floors
                |> transform

        Drip ->
            List.sortBy (\a -> a.drip.roaster) model.floors
                |> transform


iconFor : Model -> SortOption -> Html.Html Msg
iconFor model option =
    Html.a [ classes [ T.pl2 ], onClick (ToggleSort option) ]
        [ if model.sortOption /= option then
            sortIcon

          else
            case model.sortDirection of
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
