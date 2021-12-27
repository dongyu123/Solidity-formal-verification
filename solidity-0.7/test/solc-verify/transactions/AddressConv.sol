// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0;

contract C {
    address payable a;

    /// @notice postcondition a == b
    function f(address b) public {
        a = payable(b);
    }
}