// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0;

contract FCO_A {
    /// @notice postcondition r == msg.value + x
    function f(uint x) public payable returns (uint r) {
        return msg.value + x;
    }
}

contract FunctionCallOptions {
    function g(FCO_A a, uint256 amount) public {
        uint ret = a.f{value: amount}(10);
        assert(ret == amount + 10);
    }
}