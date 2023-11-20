// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/2-use-mappings-over-arrays/UsingArray.sol";
import "../src/2-use-mappings-over-arrays/UsingMapping.sol";

contract GasComparisonTest is Test {
    UsingArray usingArray;
    UsingMapping usingMapping;
    uint256 constant NUM_OPERATIONS = 100;

    function setUp() public {
        usingArray = new UsingArray();
        usingMapping = new UsingMapping();
    }

    function testMappingVsArray() public {
        uint256 totalGasUsedArray = 0;
        uint256 totalGasUsedMapping = 0;

        for (uint256 i = 0; i < NUM_OPERATIONS; i++) {
            address user = address(uint160(i + 1));
            uint256 balance = i * 1000;

            // Test gas for UsingArray
            uint256 gasBeforeArray = gasleft();
            usingArray.addUser(user, balance);
            totalGasUsedArray += (gasBeforeArray - gasleft());

            // Resetting the gas meter
            vm.deal(address(this), 1 ether);
            vm.startPrank(address(this));

            // Test gas for UsingMapping
            uint256 gasBeforeMapping = gasleft();
            usingMapping.addUser(user, balance);
            totalGasUsedMapping += (gasBeforeMapping - gasleft());

            vm.stopPrank();
        }

        uint256 averageGasUsedArray = totalGasUsedArray / NUM_OPERATIONS;
        uint256 averageGasUsedMapping = totalGasUsedMapping / NUM_OPERATIONS;

        console.log("Test made over 100 Operations");
        console.log("Tool: Foundry");
        console.log("Blockchain: Anvil");
        console.log("nSloc: 29");

        // Log average results
        emit log_named_uint(
            "Average Gas Used for addUser in Array",
            averageGasUsedArray
        );
        emit log_named_uint(
            "Average Gas Used for addUser in Mapping",
            averageGasUsedMapping
        );

        // Assert that the mapping uses less gas on average
        assertLt(
            averageGasUsedMapping,
            averageGasUsedArray,
            "Mappings should be more gas efficient on average than arrays."
        );
    }
}
