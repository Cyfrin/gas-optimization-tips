// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AssemblyOptimization {
    // Standard Solidity function to add two numbers
    function addSolidity(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    // Function using assembly to add two numbers
    function addAssembly(
        uint256 a,
        uint256 b
    ) public pure returns (uint256 result) {
        assembly {
            result := add(a, b)
        }
    }
}
