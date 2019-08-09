module FloorTests exposing (dupe, verifyDupeTest)

import Expect exposing (Expectation)
import Floors exposing (floorList)
import Test exposing (Test, describe, test)


dupe : Test
dupe =
    test "unique floors"
        (\_ ->
            List.map .floor floorList
                |> hasDupes
                |> Expect.false "Found dupes in the list"
        )


verifyDupeTest : Test
verifyDupeTest =
    describe "Sanity check hasDupes"
        [ test "no dupes"
            (\_ ->
                hasDupes [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
                    |> Expect.false "Found dupe where there is none"
            )
        , test "dupes in order"
            (\_ ->
                hasDupes [ 1, 2, 3, 4, 4, 5, 6, 7, 8, 8, 9, 10 ]
                    |> Expect.true "Missed dupe in order"
            )
        , test "dupes out of order"
            (\_ ->
                hasDupes [ 1, 2, 3, 4, 5, 6, 3, 7, 4, 8, 9, 10 ]
                    |> Expect.true "Missed dupe out of order"
            )
        ]


hasDupes : List comparable -> Bool
hasDupes aList =
    List.sort aList
        |> List.foldl checkDupItem ( Nothing, False )
        |> Tuple.second


checkDupItem : comparable -> ( Maybe comparable, Bool ) -> ( Maybe comparable, Bool )
checkDupItem a ( maybePrev, seenDup ) =
    if seenDup == True then
        ( Just a, True )

    else
        case maybePrev of
            Nothing ->
                ( Just a, False )

            Just prev ->
                ( Just a, a == prev )
