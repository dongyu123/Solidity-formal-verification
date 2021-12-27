// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0;

uint constant x_expected = 2;

contract A {
    uint constant x = 2;

    function f() public pure {
        assert(x == x_expected);
    }
}

contract B is A {
    function g() public pure {
        assert(A.x == x_expected);
    }
}
