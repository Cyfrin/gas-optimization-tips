// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExternalSum {
    function calculateSum(
        uint[] calldata numbers
    ) external pure returns (uint sum) {
        for (uint i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
    }
}
