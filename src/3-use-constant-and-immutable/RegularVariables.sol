// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RegularVariables {
    uint256 public maxSupply;
    address public owner;

    constructor(uint256 _maxSupply, address _owner) {
        maxSupply = _maxSupply;
        owner = _owner;
    }
}
