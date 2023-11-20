// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicArray {
    uint256[] public dynamicArray;

    constructor() {
        dynamicArray = [1, 2, 3, 4, 5]; // Initialize the dynamic array
    }

    function updateArray(uint256 index, uint256 value) public {
        require(index < dynamicArray.length, "Index out of range");
        dynamicArray[index] = value;
    }
}
