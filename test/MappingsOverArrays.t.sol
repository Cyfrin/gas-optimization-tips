// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/2-use-mappings-over-arrays/UsingArray.sol";
import "../src/2-use-mappings-over-arrays/UsingMapping.sol";

contract GasComparisonTest is Test {
    UsingArray usingArray;
    UsingMapping usingMapping;
    uint256 constant NUM_OPERATIONS = 100; // Adjusted to 10,000 for a larger dataset

    function setUp() public {
        usingArray = new UsingArray();
        usingMapping = new UsingMapping();

        for (uint256 i = 0; i < NUM_OPERATIONS; i++) {
            address user = address(uint160(i + 1));
            uint256 balance = i * 1000;
            usingArray.addUser(user, balance);
            usingMapping.addUser(user, balance);
        }
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

            // Test gas for UsingMapping
            uint256 gasBeforeMapping = gasleft();
            usingMapping.addUser(user, balance);
            totalGasUsedMapping += (gasBeforeMapping - gasleft());
        }

        uint256 averageGasUsedArray = totalGasUsedArray / NUM_OPERATIONS;
        uint256 averageGasUsedMapping = totalGasUsedMapping / NUM_OPERATIONS;

        emit log_named_uint(
            "Average Gas Used for addUser in Array",
            averageGasUsedArray
        );
        emit log_named_uint(
            "Average Gas Used for addUser in Mapping",
            averageGasUsedMapping
        );

        assertLt(
            averageGasUsedMapping,
            averageGasUsedArray,
            "Mapping should be more gas efficient than Array for addUser"
        );

        // Calculate the percentage saving
        uint256 saving = ((averageGasUsedArray - averageGasUsedMapping) * 100) /
            averageGasUsedArray;
        console.log(
            "Gas savings using mapping over array for addUser: ",
            saving,
            "%"
        );
    }

    function testArrayRetrievalGas() public returns (uint256) {
        uint256 totalGasUsedArray = 0;

        for (uint256 i = 0; i < NUM_OPERATIONS; i++) {
            address user = address(uint160(i + 1));
            uint256 gasBefore = gasleft();
            usingArray.getBalance(user); // This is a view function but called in a transactional context for gas measurement
            uint256 gasUsed = gasBefore - gasleft();
            totalGasUsedArray += gasUsed;
        }

        uint256 averageGasUsedArray = totalGasUsedArray / NUM_OPERATIONS;
        emit log_named_uint(
            "Average Gas Used for getBalance in Array",
            averageGasUsedArray
        );

        return averageGasUsedArray;
    }

    function testMappingRetrievalGas() public returns (uint256) {
        uint256 totalGasUsedMapping = 0;

        for (uint256 i = 0; i < NUM_OPERATIONS; i++) {
            address user = address(uint160(i + 1));
            uint256 gasBefore = gasleft();
            usingMapping.getBalance(user); // This is a view function but called in a transactional context for gas measurement
            uint256 gasUsed = gasBefore - gasleft();
            totalGasUsedMapping += gasUsed;
        }

        uint256 averageGasUsedMapping = totalGasUsedMapping / NUM_OPERATIONS;
        emit log_named_uint(
            "Average Gas Used for getBalance in Mapping",
            averageGasUsedMapping
        );

        return averageGasUsedMapping;
    }

    function testEfficiencyComparisonMappingVsArray() public {
        uint256 avgArrayGas = testArrayRetrievalGas();
        uint256 avgMappingGas = testMappingRetrievalGas();

        assertLt(
            avgMappingGas,
            avgArrayGas,
            "Mapping should be more gas efficient than Array for getBalance"
        );

        // Calculate the percentage saving
        uint256 saving = ((avgArrayGas - avgMappingGas) * 100) / avgArrayGas;
        console.log("Gas savings using mapping over array: ", saving, "%");
    }
}
