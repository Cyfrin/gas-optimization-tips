// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingStorage {
    struct Vote {
        address voter;
        bool choice;
    }

    Vote[] public votes;

    function vote(bool _choice) external {
        votes.push(Vote(msg.sender, _choice));
    }
}
