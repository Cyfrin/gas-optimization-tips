// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/9-pack-lower-than-256/NonPackedVariables.sol";
import "../src/9-pack-lower-than-256/PackedVariables.sol";

contract PackedVariablesTest is Test {
    NonPackedVariables nonPacked;
    PackedVariables packed;

    function setUp() public {
        nonPacked = new NonPackedVariables();
        packed = new PackedVariables();
    }

    function testNonPackedGasUsage() public returns (uint256) {
        uint256 totalGasUsed = 0;

        for (uint256 i = 0; i < 100; i++) {
            uint256 gasBefore = gasleft();
            nonPacked.setVariables(true, i, false);
            totalGasUsed += gasBefore - gasleft();
        }

        uint256 averageGasUsed = totalGasUsed / 100;
        emit log_named_uint(
            "Average Gas Used for Non-Packed Variables",
            averageGasUsed
        );
        return averageGasUsed;
    }

    function testPackedGasUsage() public returns (uint256) {
        uint256 totalGasUsed = 0;

        for (uint256 i = 0; i < 100; i++) {
            uint256 gasBefore = gasleft();
            packed.setVariables(true, false, i);
            totalGasUsed += gasBefore - gasleft();
        }

        uint256 averageGasUsed = totalGasUsed / 100;
        emit log_named_uint(
            "Average Gas Used for Packed Variables",
            averageGasUsed
        );
        return averageGasUsed;
    }

    function testEfficiencyComparisonPacked() public {
        uint256 avgGasUsedNonPacked = testNonPackedGasUsage();
        uint256 avgGasUsedPacked = testPackedGasUsage();

        if (avgGasUsedNonPacked > avgGasUsedPacked) {
            uint256 saving = ((avgGasUsedNonPacked - avgGasUsedPacked) * 100) /
                avgGasUsedNonPacked;
            console.log(
                "Gas savings using packed variables over non-packed: ",
                saving,
                "%"
            );
        } else {
            console.log(
                "Unexpected result: Non-packed operation used less gas than packed"
            );
        }
    }
}
