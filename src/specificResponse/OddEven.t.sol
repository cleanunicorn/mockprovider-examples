// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import {DSTest} from "lib/ds-test/src/test.sol";
import {MockProvider} from "lib/mockprovider/src/MockProvider.sol";

import {OddEven} from "./OddEven.sol";
import {IOddEven} from "./IOddEven.sol";

contract OddEvenTest is DSTest {
    MockProvider internal provider;

    function setUp() public {
        provider = new MockProvider();
    }

    function test_ReturnsOddAndEvenNumbers_WhenRequested() public {
        // Make it return 1 when calling .getOdd()
        provider.givenQueryReturnResponse(
            // Respond to `.getOdd()`
            abi.encodePacked(IOddEven.getOdd.selector),
            // Encode the response
            MockProvider.ReturnData({
                success: true,
                data: abi.encodePacked(uint256(1))
            }),
            false
        );

        // Make it return 2 when calling .getEven()
        provider.givenQueryReturnResponse(
            // Respond to `.getEven()`
            abi.encodePacked(IOddEven.getEven.selector),
            // Encode the response
            MockProvider.ReturnData({
                success: true,
                data: abi.encodePacked(uint256(2))
            }),
            false
        );        

        // Cast the mock provider as IOddEven to get easy access to 
        // the methods `getOdd()` and `getEven()`
        IOddEven mockOddEven = IOddEven(address(provider));

        // Check if it returns odd or even numbers
        uint256 oddNumber = mockOddEven.getOdd();
        assertTrue(oddNumber % 2 == 1, "Expected odd number");
        uint256 evenNumber = mockOddEven.getEven();
        assertTrue(evenNumber % 2 == 0, "Expected even number");            
    }
}
