// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract InefficientContract {
    uint public result;
    uint private unusedVariable = 10;

    function calculate(uint a, uint b) public {
        result = a + b; // Simple operation to use as a test
        // This next line alters the state unnecessarily, wasting gas.
        unusedVariable = unusedVariable + a;
    }
}
