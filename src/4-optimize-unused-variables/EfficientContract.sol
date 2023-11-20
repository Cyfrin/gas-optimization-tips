// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EfficientContract {
    uint public result;

    function calculate(uint a, uint b) public {
        result = a + b; // Only the necessary operation is performed
    }
}
