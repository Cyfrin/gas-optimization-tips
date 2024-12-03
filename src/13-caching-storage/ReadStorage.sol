// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReadStorage {
    uint256[] public numbers;

    function addNumbers(uint256[] memory newNumbers) public {
        for (uint256 i = 0; i < newNumbers.length; i++) {
            numbers.push(newNumbers[i]);
        }
    }

    function sumNumbers() public view returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }
}
