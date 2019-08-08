module Floors exposing (Coffee, Floor, Machine, floorList)


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
