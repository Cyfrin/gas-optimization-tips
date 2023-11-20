// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract UsingUint256 {
    uint256 public a = 12;
    uint256 public b = 13;
    uint256 public c = 14;

    function sum() public view returns (uint256) {
        return a + b + c;
    }
}
