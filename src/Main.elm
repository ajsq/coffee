module Main exposing (main)

import Browser
import Element
import Html


main : Program () Model Msg
main =
    Browser.document
        { view = docView
        , init = init
        , update = update
        , subscriptions = subs
        }


init : () -> ( Model, Cmd msg )
init _ =
    ( initModel, Cmd.none )


type alias Model =
    { hello : Int
    }


initModel : Model
initModel =
    { hello = 0 }


type Msg
    = Nothing


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    ( model, Cmd.none )


docView : Model -> Browser.Document Msg
docView model =
    { title = "main"
    , body = [ view model ]
    }


view : Model -> Html.Html msg
view _ =
    Element.layout []
        (Element.el [] (Element.text "hi"))


subs : Model -> Sub Msg
subs _ =
    Sub.none
