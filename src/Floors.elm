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
        fidalgo_islands_organic
        (stumptown "House Blend" "Trapper Creek Decaf")
    , Floor 34
        vita_theo_novacella
        onecup_queen_cascadia
    , Floor 41
        umbria_etrusco_mezzanote
        peets_dickasons_decaf
    , Floor 36
        zoka_double_paladino
        mukilteo_hippie_decaf
    , Floor 37
        umbria_etrusco_mezzanote
        starbucks_pike_place
    , Floor 38
        fidalgo_centro_organic
        (sbc "6th Avenue Bistro" "Decaf Portside Blend")
    , Floor 39
        victrola_empire_deco
        callies_house_decaf
    , Floor 40
        fidalgo_islands_organic
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
    , Floor 24
        fidalgo_islands_organic
        stumptown_holler_trapper
    , Floor 25
        vita_theo_novacella
        onecup_queen_cascadia
    , Floor 26
        umbria_etrusco_mezzanote
        starbucks_pike_place
    , Floor 27
        fidalgo_centro_organic
        sbc_sig4_decaf
    , Floor 28
        zoka_double_paladino
        mukilteo_hippie_decaf
    , Floor 29
        fidalgo_islands_organic
        stumptown_holler_trapper
    , Floor 30
        umbria_etrusco_mezzanote
        peets_dickasons_decaf
    , Floor 31
        victrola_empire_deco
        callies_house_decaf
    , Floor 32
        fidalgo_centro_organic
        sbc_sig4_decaf
    , Floor 46
        zoka_double_paladino
        mukilteo_hippie_decaf
    , Floor 47
        vita_theo_novacella
        callies_house_decaf
    ]


fidalgo : Roaster
fidalgo =
    Machine "Fidalgo Coffee Roasters"


fidalgo_islands_organic : Machine
fidalgo_islands_organic =
    fidalgo "Islands Espresso" "Organic Decaf"


fidalgo_double_organic : Machine
fidalgo_double_organic =
    fidalgo "Organic Espresso" "Organic Decaf"


fidalgo_centro_organic : Machine
fidalgo_centro_organic =
    fidalgo "Organic Centro" "Organic Decaf"


stumptown : Roaster
stumptown =
    Machine "Stumptown Coffee Roasters"


sbc : Roaster
sbc =
    Machine "Seattle's Best Coffee"


sbc_sig4_decaf : Machine
sbc_sig4_decaf =
    sbc "Signature Blend No 4" "Decaf Portside Blend"


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


peets_dickasons_decaf : Machine
peets_dickasons_decaf =
    peets "Major Dickason's Blend" "Decaf House Blend"


starbucks_pike_place : Machine
starbucks_pike_place =
    Machine "Starbucks" "Pike Place Roast" "Decaf Pike Place Roast"


zoka_double_paladino : Machine
zoka_double_paladino =
    Machine "Zoka Coffee" "Espresso Paladino" "Decaf Espresso Paladino"


mukilteo_hippie_decaf : Machine
mukilteo_hippie_decaf =
    Machine "Mukilteo Coffee Roasters" "Happy Hippie" "Mukilteo Decaf"


victrola_empire_deco : Machine
victrola_empire_deco =
    Machine "Victrola Coffee Roasters" "Empire Blend" "Deco Decaf"


callies_house_decaf : Machine
callies_house_decaf =
    Machine "callie's" "House Blend" "Decaf"
