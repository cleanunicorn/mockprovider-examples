// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

interface IOddEven {
    function isEven(uint256 x) external pure returns (bool);

    function isOdd(uint256 x) external pure returns (bool);

    function getOdd() external pure returns (uint256);

    function getEven() external pure returns (uint256);
}
