module FloorTests exposing (noRealTest)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)


noRealTest : Test
noRealTest =
    test "not doing any actual testing right now" <|
        \_ -> Expect.equal 1 1
