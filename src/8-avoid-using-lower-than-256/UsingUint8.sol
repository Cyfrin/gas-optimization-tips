// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract UsingUint8 {
    uint8 public a = 12;
    uint8 public b = 13;
    uint8 public c = 14;

    function sum() public view returns (uint8) {
        return a + b + c;
    }
}
