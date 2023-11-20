// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/7-use-well-tested-libraries-whenever-possible/NFTWithOpenZeppelin.sol";
import "../src/7-use-well-tested-libraries-whenever-possible/NFTWithoutOpenZeppelin.sol";

contract OpenZeppelinEnumComparisonTest is Test {
    NFTWithOpenZeppelin nftWithOZ;
    NFTWithoutOpenZeppelin nftWithoutOZ;

    function setUp() public {
        nftWithOZ = new NFTWithOpenZeppelin();
        nftWithoutOZ = new NFTWithoutOpenZeppelin();
    }

    function testMintWithOpenZeppelin() public {
        uint256 gasBefore = gasleft();
        nftWithOZ.mint(address(this), 1);
        uint256 gasAfter = gasleft();
        console.log("nSLOC: 8");
        emit log_named_uint(
            "Gas used with OpenZeppelin Enumerable",
            gasBefore - gasAfter
        );
    }

    function testMintWithoutOpenZeppelin() public {
        uint256 gasBefore = gasleft();
        nftWithoutOZ.mint(address(this), 1);
        uint256 gasAfter = gasleft();
        console.log("nSLOC: 19");
        emit log_named_uint(
            "Gas used without OpenZeppelin Enumerable",
            gasBefore - gasAfter
        );
    }
}
