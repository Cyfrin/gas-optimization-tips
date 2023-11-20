// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/5-delete-unused-variables/WithDelete.sol";
import "../src/5-delete-unused-variables/WithoutDelete.sol";

contract DeleteUnsusedVariables is Test {
    WithDelete withDelete;
    WithoutDelete withoutDelete;

    uint constant NUMBER_OF_ITERATIONS = 100;

    function setUp() public {
        withDelete = new WithDelete();
        withoutDelete = new WithoutDelete();
    }

    function testGasUsageWithDelete() public {
        uint totalGasUsedWithDelete = 0;
        for (uint i = 0; i < NUMBER_OF_ITERATIONS; i++) {
            uint gasBefore = gasleft();
            withDelete.useDelete();
            totalGasUsedWithDelete += (gasBefore - gasleft());
        }
        emit log_named_uint(
            "Total Gas Used with delete",
            totalGasUsedWithDelete
        );
    }

    function testGasUsageWithoutDelete() public {
        uint totalGasUsedWithoutDelete = 0;
        for (uint i = 0; i < NUMBER_OF_ITERATIONS; i++) {
            uint gasBefore = gasleft();
            withoutDelete.skipDelete();
            totalGasUsedWithoutDelete += (gasBefore - gasleft());
        }
        emit log_named_uint(
            "Total Gas Used without delete",
            totalGasUsedWithoutDelete
        );
    }

    function testGasUsageComparison() public {
        uint totalGasUsedWithDelete = 0;
        uint totalGasUsedWithoutDelete = 0;

        for (uint i = 0; i < NUMBER_OF_ITERATIONS; i++) {
            uint gasBeforeWith = gasleft();
            withDelete.useDelete();
            totalGasUsedWithDelete += (gasBeforeWith - gasleft());

            uint gasBeforeWithout = gasleft();
            withoutDelete.skipDelete();
            totalGasUsedWithoutDelete += (gasBeforeWithout - gasleft());
        }

        emit log_named_uint(
            "Total Gas Used with delete",
            totalGasUsedWithDelete
        );
        emit log_named_uint(
            "Total Gas Used without delete",
            totalGasUsedWithoutDelete
        );

        if (totalGasUsedWithoutDelete > 0) {
            uint savingsPercentage = ((totalGasUsedWithoutDelete -
                totalGasUsedWithDelete) * 100) / totalGasUsedWithoutDelete;
            console.log("Gas Savings", savingsPercentage, "%");
        } else {
            emit log("No gas savings observed");
        }
    }
}
