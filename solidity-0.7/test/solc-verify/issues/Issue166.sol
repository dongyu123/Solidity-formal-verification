// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0;

contract Test {
  enum B { A }
  struct AA {
    B s;
  }

  AA private _aa;

  function test() public view {
    B b = _aa.s;
  }
}
