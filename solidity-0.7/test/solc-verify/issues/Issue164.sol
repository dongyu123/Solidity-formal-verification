// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0;

interface I164 { function f(address a) external returns (uint v); }

contract Issue164 {
    I164 i;
    function trycatch() public returns (uint) {
        try i.f(msg.sender) returns (uint v) {
            return v;
        } catch Error(string memory /*reason*/) {
            return 0;
        } catch (bytes memory /*lowLevelData*/) {
            return 0;
        }
    }

    function f() public pure virtual returns (uint) {
        return 0;
    }

    function arrayslices(bytes calldata arr) external returns (bytes1) {
        return arr[4:5][1];
    }
}

contract Issue164_derived is Issue164 {
    function f() public pure override returns (uint) {
        return 1;
    }
}