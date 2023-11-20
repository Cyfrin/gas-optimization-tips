// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

contract WithDelete {
    uint public data;

    function useDelete() public {
        data = 123; // Example operation
        delete data; // Reset data to its default value
    }
}
