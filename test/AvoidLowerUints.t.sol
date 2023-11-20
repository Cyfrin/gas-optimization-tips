// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/8-avoid-using-lower-than-256/UsingUint8.sol";
import "../src/8-avoid-using-lower-than-256/UsingUint256.sol";

contract GasComparisonTest is Test {
    UsingUint8 usingUint8;
    UsingUint256 usingUint256;
    uint256 constant NUM_ITERATIONS = 100;

    function setUp() public {
        usingUint8 = new UsingUint8();
        usingUint256 = new UsingUint256();
    }

    function testUint8SumGas() public returns (uint256) {
        uint256 totalGasUsedUint8 = 0;

        for (uint256 i = 0; i < NUM_ITERATIONS; i++) {
            uint256 gasBefore = gasleft();
            usingUint8.sum();
            totalGasUsedUint8 += (gasBefore - gasleft());
        }

        uint256 averageGasUsedUint8 = totalGasUsedUint8 / NUM_ITERATIONS;
        emit log_named_uint(
            "Average Gas Used for sum in UsingUint8",
            averageGasUsedUint8
        );
        return averageGasUsedUint8;
    }

    function testUint256SumGas() public returns (uint256) {
        uint256 totalGasUsedUint256 = 0;

        for (uint256 i = 0; i < NUM_ITERATIONS; i++) {
            uint256 gasBefore = gasleft();
            usingUint256.sum();
            totalGasUsedUint256 += (gasBefore - gasleft());
        }

        uint256 averageGasUsedUint256 = totalGasUsedUint256 / NUM_ITERATIONS;
        emit log_named_uint(
            "Average Gas Used for sum in UsingUint256",
            averageGasUsedUint256
        );
        return averageGasUsedUint256;
    }

    function testEfficiencyComparisonLower() public {
        uint256 avgGasUsedUint8 = testUint8SumGas();
        uint256 avgGasUsedUint256 = testUint256SumGas();

        if (avgGasUsedUint8 >= avgGasUsedUint256) {
            uint256 saving = ((avgGasUsedUint8 - avgGasUsedUint256) * 100) /
                avgGasUsedUint8;
            console.log("Gas savings using uint256 over uint8: ", saving, "%");
        } else {
            console.log(
                "Unexpected result: uint8 operation used less gas than uint256"
            );
        }
    }
}
