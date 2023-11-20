// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/1-minimize-on-chain-data/VotingStorage.sol";
import "../src/1-minimize-on-chain-data/VotingEvents.sol";

contract VotingGasComparisonTest is Test {
    VotingStorage votingStorage;
    VotingEvents votingEvents;

    function setUp() public {
        votingStorage = new VotingStorage();
        votingEvents = new VotingEvents();
    }

    function testVotingStorageCost() public {
        uint256 totalGasUsedStorage = 0;

        for (uint256 i = 0; i < 100; i++) {
            vm.startPrank(address(uint160(i)));
            uint256 gasBefore = gasleft();
            votingStorage.vote(i % 2 == 0);
            totalGasUsedStorage += (gasBefore - gasleft());
            vm.stopPrank();
        }

        uint256 averageGasUsedStorage = totalGasUsedStorage / 100;
        emit log_named_uint(
            "Average Gas Used With Storage",
            averageGasUsedStorage
        );
    }

    function testVotingEventsCost() public {
        uint256 totalGasUsedEvents = 0;

        for (uint256 i = 0; i < 100; i++) {
            vm.startPrank(address(uint160(i)));
            uint256 gasBefore = gasleft();
            votingEvents.vote(i % 2 == 0);
            totalGasUsedEvents += (gasBefore - gasleft());
            vm.stopPrank();
        }

        uint256 averageGasUsedEvents = totalGasUsedEvents / 100;
        emit log_named_uint(
            "Average Gas Used With Events",
            averageGasUsedEvents
        );
    }
}
