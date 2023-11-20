// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NonPackedVariables {
    bool public a = true;
    uint256 public b = 14;
    bool public c = false;

    function setVariables(bool _a, uint256 _b, bool _c) public {
        a = _a;
        b = _b;
        c = _c;
    }
}
