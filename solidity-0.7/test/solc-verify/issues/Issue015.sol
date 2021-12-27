// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0;

contract L {}
contract C {
    function f() public {
        new L();
    }
}
