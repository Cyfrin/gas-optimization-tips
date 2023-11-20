// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/3-use-constant-and-immutable/RegularVariables.sol";
import "../src/3-use-constant-and-immutable/ConstantImmutable.sol";

contract ConstantImmutableTest is Test {
    function testRegularVariablesCost() public {
        uint256 gasBefore = gasleft();
        new RegularVariables(1000, address(this));
        uint256 gasUsed = gasBefore - gasleft();
        console.log("nSloc: 9");
        console.log("Blockchain: Anvil");
        emit log_named_uint("Gas Used for Regular Variables Contract", gasUsed);
    }

    function testConstantImmutableCost() public {
        uint256 gasBefore = gasleft();
        new ConstantImmutable(address(this));
        uint256 gasUsed = gasBefore - gasleft();
        console.log("nSloc: 8");
        console.log("Blockchain: Anvil");
        emit log_named_uint(
            "Gas Used for Constant Immutable Contract",
            gasUsed
        );
    }
}
