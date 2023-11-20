// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UsingMapping {
    mapping(address => uint256) public userBalances;

    function addUser(address _user, uint256 _balance) public {
        userBalances[_user] = _balance;
    }

    // Function to fetch user balance directly from mapping
    function getBalance(address _user) public view returns (uint256) {
        return userBalances[_user];
    }
}
