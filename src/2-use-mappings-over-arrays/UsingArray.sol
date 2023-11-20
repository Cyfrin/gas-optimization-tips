// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UsingArray {
    struct User {
        address userAddress;
        uint256 balance;
    }

    User[] public users;

    function addUser(address _user, uint256 _balance) public {
        users.push(User(_user, _balance));
    }

    // Function to simulate user retrieval as would be required in an array
    function getBalance(address _user) public view returns (uint256) {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i].userAddress == _user) {
                return users[i].balance;
            }
        }
        return 0;
    }
}
