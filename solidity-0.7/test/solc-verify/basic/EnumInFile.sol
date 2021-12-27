// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0;

enum Fruit { Apple, Banana, Strawberry }

contract C {
    Fruit fruit;

    /// @notice postcondition fruit == fr
    function f(Fruit fr) public {
        fruit = fr;
    }
}
