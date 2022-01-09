// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import {DSTest} from "lib/ds-test/src/test.sol";
import {MockProvider} from "lib/mockprovider/src/MockProvider.sol";

import {ISavesNumbers} from "./ISavesNumbers.sol";
import {ReportNumber} from "./ReportNumber.sol";

contract ReportNumberTest is DSTest {
    MockProvider internal savesNumbersMockProvider;

    ReportNumber internal reportNumber;

    function setUp() public {
        savesNumbersMockProvider = new MockProvider();
        savesNumbersMockProvider.givenQueryReturnResponse(
            // When the `save` method is called
            abi.encodeWithSelector(ISavesNumbers.save.selector),
            // Execution is successful with no response            
            MockProvider.ReturnData({
                success: true,
                data: ""
            }),
            // Call is logged
            true
        );

        // Initialize the tested contract with the mock provider
        reportNumber = new ReportNumber(address(savesNumbersMockProvider));
    }

    function test_CheckEvenNumbers_AreSaved() public {
        uint256 number = 4;

        // Call the method
        reportNumber.checkAndPossiblySave(number);

        // Expect the SavesNumbers contract was called with the correct parameters
        MockProvider.CallData memory cd = savesNumbersMockProvider.getCallData(0);
        assertEq(cd.caller, address(reportNumber), "Should be called by `ReportNumber`");
        assertEq(cd.functionSelector, ISavesNumbers.save.selector, "Should call `save`");
        assertEq(keccak256(cd.data), keccak256(abi.encodeWithSelector(ISavesNumbers.save.selector, number)), "Should call `save` with the correct parameters");
        assertEq(cd.value, 0, "Should not send ether");
    }

    function testFail_CheckOddNumbers_AreNotSaved() public {
        uint256 number = 3;

        // Call the method
        reportNumber.checkAndPossiblySave(number);

        // Expect the SavesNumbers contract was called with the correct parameters
        MockProvider.CallData memory cd = savesNumbersMockProvider.getCallData(0);
        assertEq(cd.caller, address(reportNumber), "Should be called by `ReportNumber`");
        assertEq(cd.functionSelector, ISavesNumbers.save.selector, "Should call `save`");
        assertEq(keccak256(cd.data), keccak256(abi.encodeWithSelector(ISavesNumbers.save.selector, number)), "Should call `save` with the correct parameters");
        assertEq(cd.value, 0, "Should not send ether");
    }    
}
