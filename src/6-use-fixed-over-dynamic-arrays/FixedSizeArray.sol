// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FixedSizeArray {
    uint256[5] public fixedArray;

    constructor() {
        fixedArray = [1, 2, 3, 4, 5]; // Initialize the fixed-size array
    }

    function updateArray(uint256 index, uint256 value) public {
        require(index < fixedArray.length, "Index out of range");
        fixedArray[index] = value;
    }
}
