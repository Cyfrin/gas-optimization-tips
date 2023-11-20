// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/4-optimize-unused-variables/InefficientContract.sol";
import "../src/4-optimize-unused-variables/EfficientContract.sol";

contract VariableEfficiencyTest is Test {
    InefficientContract inefficient;
    EfficientContract efficient;

    function setUp() public {
        inefficient = new InefficientContract();
        efficient = new EfficientContract();
    }

    function testInefficientContractGas() public {
        uint256 gasBefore = gasleft();
        inefficient.calculate(3, 3);
        uint256 gasAfter = gasleft();
        console.log("Tool: Foundry");
        console.log("Blockchain: Anvil");
        console.log("nSloc: 9");
        emit log_named_uint(
            "Gas used by InefficientContract",
            gasBefore - gasAfter
        );
    }

    function testEfficientContractGas() public {
        uint256 gasBefore = gasleft();
        efficient.calculate(3, 3);
        uint256 gasAfter = gasleft();
        console.log("Tool: Foundry");
        console.log("Blockchain: Anvil");
        console.log("nSloc: 7");
        emit log_named_uint(
            "Gas used by EfficientContract",
            gasBefore - gasAfter
        );
    }
}
