// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0;

contract Gas {
    function g(uint256 amount) public returns (bool) {
        (bool ok, ) = msg.sender.call{gas: amount}("");
        return ok;
    }
}