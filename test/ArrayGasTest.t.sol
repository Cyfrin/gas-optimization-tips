// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/6-use-fixed-over-dynamic-arrays/FixedSizeArray.sol";
import "../src/6-use-fixed-over-dynamic-arrays/DynamicArray.sol";

contract ArrayGasTest is Test {
    FixedSizeArray fixedSize;
    DynamicArray dynamic;

    function setUp() public {
        fixedSize = new FixedSizeArray();
        dynamic = new DynamicArray();
    }

    function testFixedSizeArrayGas() public {
        uint256 gasBefore = gasleft();
        fixedSize.updateArray(3, 10);
        uint256 gasAfter = gasleft();
        console.log("nSloc: 11");
        console.log("Blockchain: Anvil");
        emit log_named_uint(
            "Gas used for fixed-size array update",
            gasBefore - gasAfter
        );
    }

    function testDynamicArrayGas() public {
        uint256 gasBefore = gasleft();
        dynamic.updateArray(3, 10);
        uint256 gasAfter = gasleft();
        console.log("nSloc: 11");
        console.log("Blockchain: Anvil");
        emit log_named_uint(
            "Gas used for dynamic array update",
            gasBefore - gasAfter
        );
    }

    function runBothTests() public {
        testFixedSizeArrayGas();
        testDynamicArrayGas();
    }
}
