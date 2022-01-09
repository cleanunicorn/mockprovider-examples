// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import {DSTest} from "lib/ds-test/src/test.sol";
import {MockProvider} from "lib/mockprovider/src/MockProvider.sol";

import {ITheAnswer} from "./ITheAnswer.sol";

contract ReturnDefaultValueTest is DSTest {
    MockProvider internal provider;

    function setUp() public {
        provider = new MockProvider();

        // Make the provider successfully respond with 42 for any request
        provider.setDefaultResponse(
            MockProvider.ReturnData({
                success: true,
                data: abi.encode(uint256(42))
            })
        );
    }

    function test_Expect_LowLevelCallReceives_42() public {
        // Do a low level call and check the response
        (bool success, bytes memory response) = address(provider).call(
            "0xdeadbeef"
        );

        assertTrue(success, "Expected success");

        uint256 result = abi.decode(response, (uint256));
        assertEq(result, 42, "Expected 42");
    }

    function test_Expect_InterfaceReceives_42() public {
        ITheAnswer theAnswer = ITheAnswer(address(provider));

        uint256 theUltimateAnswer = theAnswer
            .theUltimateQuestionOfLifeTheUniverseAndEverything();

        assertEq(theUltimateAnswer, 42, "Expected 42");
    }
}
