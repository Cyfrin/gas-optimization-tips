// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/12-use-assembly/AssemblyOptimization.sol";

contract AssemblyOptimizationTest is Test {
    AssemblyOptimization optimizationContract;

    function setUp() public {
        optimizationContract = new AssemblyOptimization();
    }

    function testAddSolidity() public {
        uint256 gasBefore = gasleft();
        optimizationContract.addSolidity(1, 2);
        uint256 gasAfter = gasleft();
        emit log_named_uint("Gas used for addSolidity", gasBefore - gasAfter);
    }

    function testAddAssembly() public {
        uint256 gasBefore = gasleft();
        optimizationContract.addAssembly(1, 2);
        uint256 gasAfter = gasleft();
        emit log_named_uint("Gas used for addAssembly", gasBefore - gasAfter);
    }
}
