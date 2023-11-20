// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingEvents {
    event Voted(address indexed voter, bool choice);

    function vote(bool _choice) external {
        emit Voted(msg.sender, _choice);
    }
}
