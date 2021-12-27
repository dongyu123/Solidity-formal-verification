// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0;

struct S {
    int x;
    int y;
}

contract C {
    struct T {
        S s;
        int z;
    }

    T t;

    /// @notice postcondition t.s.x == x
    function set_x(int x) public {
        t.s.x = x;
    }

    /// @notice postcondition t.s.y == y
    function set_y(int y) public {
        t.s.y = y;
    }

    /// @notice postcondition t.z == z
    function set_z(int z) public {
        t.z = z;
    }
}