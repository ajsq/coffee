module Floors exposing (Coffee, Floor, Machine, floorList)

import Json.Decode as D



-- FLOOR LIST


type alias Floor =
    { floor : Int
    , espresso : Machine
    , drip : Machine
    }


type alias Machine =
    { roaster : String
    , left : Coffee
    , right : Coffee
    }


type alias Coffee =
    String


floorList : D.Value -> List Floor
floorList rawFloors =
    D.decodeValue floorListDecoder rawFloors
        |> Result.withDefault []


floorListDecoder : D.Decoder (List Floor)
floorListDecoder =
    D.list
        (D.map3 Floor
            (D.field "floor" intAsString)
            (D.map3 Machine
                (D.field "espresso_roaster" D.string)
                (D.field "espresso_left" D.string)
                (D.field "espresso_right" D.string)
            )
            (D.map3 Machine
                (D.field "drip_roaster" D.string)
                (D.field "drip_left" D.string)
                (D.field "drip_right" D.string)
            )
        )


intAsString : D.Decoder Int
intAsString =
    D.map (\a -> String.toInt a |> Maybe.withDefault 0) D.string
