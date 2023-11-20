// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract WithoutDelete {
    uint public data;

    function skipDelete() public {
        data = 123; // Example operation
        // Here we're not using delete
    }
}
