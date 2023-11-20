// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ConstantImmutable {
    uint256 public constant MAX_SUPPLY = 1000;
    address public immutable owner;

    constructor(address _owner) {
        owner = _owner;
    }
}
