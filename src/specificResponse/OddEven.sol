// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import {IOddEven} from "./IOddEven.sol";

contract OddEven is IOddEven {
    function isEven(uint256 x) public pure override(IOddEven) returns (bool) {
        return x % 2 == 0;
    }

    function isOdd(uint256 x) public pure override(IOddEven) returns (bool) {
        return x % 2 == 1;
    }

    function getOdd() public pure override(IOddEven) returns (uint256) {
        return 1;
    }

    function getEven() public pure override(IOddEven) returns (uint256) {
        return 2;
    }
}
