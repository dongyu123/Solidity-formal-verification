// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0;

contract Thing {
    string public id;
}

contract otherThing {
    function f(Thing t) public view returns(string memory)
    {
        string memory s = t.id();
        return s;
    }
}