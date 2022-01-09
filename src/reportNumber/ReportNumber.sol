// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import {DSTest} from "lib/ds-test/src/test.sol";
import {MockProvider} from "lib/mockprovider/src/MockProvider.sol";

import {ISavesNumbers} from "./ISavesNumbers.sol";

contract ReportNumber {
    ISavesNumbers internal savesNumbers;

    constructor(address savesNumbers_) {
        savesNumbers = ISavesNumbers(savesNumbers_);
    }

    function checkAndPossiblySave(uint256 n_) public {
        if (n_ % 2 == 0) {
            savesNumbers.save(n_);
        } else {
            // does not save the number
        }
    }
}
