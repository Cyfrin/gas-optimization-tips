// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/14-avoid-initializing-variables/WithInitializing.sol";
import "../src/14-avoid-initializing-variables/WithoutInitializing.sol";

contract InitializeComparisonTest is Test {

    function testWithInitializingCost() public returns (uint256){
        uint256 gasBefore = gasleft();
        new WithInitializing();
        uint256 gasUsed = gasBefore - gasleft();
        return (gasUsed);    
    }

    function testWithoutInitializingCost() public returns (uint256){
        uint256 gasBefore = gasleft();
        new WithoutInitializing();
        uint256 gasUsed = gasBefore - gasleft();
        return (gasUsed);
    }

    function testEfficiencyComparisonInitialization () public {
        uint256 withoutInitializingCost = testWithoutInitializingCost();
        uint256 withInitializingCost = testWithInitializingCost();

        emit log_named_uint(
            "Gas Used When Not Initializing Variables to Default Value",
            withoutInitializingCost
        );

        emit log_named_uint(
            "Gas Used When Initializing Variables to Default Value",
            withInitializingCost
        );

        assertLt(withoutInitializingCost,
            withInitializingCost,
            "Not initializing a variable with default value saves gas"
        );

        // Calculate the percentage saving
        uint256 saving = ((withInitializingCost - withoutInitializingCost) * 100) / withInitializingCost;
        console.log("Gas savings not initializing variable value to default: ", saving, "%");
    }
}
