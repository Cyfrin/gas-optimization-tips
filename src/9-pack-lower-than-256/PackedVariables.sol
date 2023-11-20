// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PackedVariables {
    bool public a = true;
    bool public c = false;
    uint256 public b = 14;

    function setVariables(bool _a, bool _c, uint256 _b) public {
        a = _a;
        c = _c;
        b = _b;
    }
}
