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


type alias Roaster =
    String -> String -> Machine


floorList : List Floor
floorList =
    [ Floor 35
        fidalgo_organic_decaf
        (stumptown "House Blend" "Trapper Creek Decaf")
    , Floor 34
        vita_theo_novacella
        onecup_queen_cascadia
    , Floor 41
        umbria_etrusco_mezzanote
        (peets "Major Dickason's Blend" "Decaf House Blend")
    , Floor 36
        (Machine "Zoka Coffee" "Espresso Paladino" "Decaf Espresso Paladino")
        (Machine "Mukilteo Coffee Roasters" "Happy Hippie" "Mukilteo Decaf")
    , Floor 37
        umbria_etrusco_mezzanote
        (Machine "Starbucks" "Pike Place Roast" "Decaf Pike Place Roast")
    , Floor 38
        (fidalgo "Organic Centro" "Organic Decaf")
        (Machine "Seattle's Best Coffee" "6th Avenue Bistro" "Decaf Portside Blend")
    , Floor 39
        (Machine "Victrola Coffee Roasters" "Empire Blend" "Deco Decaf")
        (Machine "callie's" "House Blend" "Decaf")
    , Floor 40
        fidalgo_organic_decaf
        stumptown_holler_trapper
    , Floor 42
        vita_theo_novacella
        onecup_queen_cascadia
    , Floor 43
        fidalgo_double_organic
        (peets "House Blend" "Decaf House Blend")
    , Floor 45
        fidalgo_double_organic
        stumptown_holler_trapper
    ]


fidalgo : Roaster
fidalgo =
    Machine "Fidalgo Coffee Roasters"


fidalgo_organic_decaf : Machine
fidalgo_organic_decaf =
    fidalgo "Islands Espresso" "Organic Decaf"


fidalgo_double_organic : Machine
fidalgo_double_organic =
    fidalgo "Organic Espresso" "Organic Decaf"


stumptown : Roaster
stumptown =
    Machine "Stumptown Coffee Roasters"


stumptown_holler_trapper : Machine
stumptown_holler_trapper =
    stumptown "Holler Mountain Organic" "Trapper Creek Decaf"


umbria_etrusco_mezzanote : Machine
umbria_etrusco_mezzanote =
    Machine "Cafe Umbria" "Arco Etrusco" "Mezzanotte Blend"


vita_theo_novacella : Machine
vita_theo_novacella =
    Machine "Cafe Vita" "Theo Blend" "Novacella Decaf"


onecup_queen_cascadia : Machine
onecup_queen_cascadia =
    Machine "One Cup" "Queen City" "Decaf Republic of Cascadia"


peets : Roaster
peets =
    Machine "Peet's"
