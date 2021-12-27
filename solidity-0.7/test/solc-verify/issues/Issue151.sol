// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0;

contract test {
    mapping(uint=>uint) map;
    function fun() public view {
        mapping(uint=>uint) storage a = map;
        mapping(uint=>uint) storage b = map;
        b = a;
        (b) = a;
        (b, b) = (a, a);
    }
}
