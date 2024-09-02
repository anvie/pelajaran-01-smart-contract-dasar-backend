// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract UppercaseString {
    function toUpperCase(string memory str) public pure returns (string memory) {
        bytes memory bStr = bytes(str);
        for (uint i = 0; i < bStr.length; i++) {
            if (bStr[i] >= 0x61 && bStr[i] <= 0x7A) {
                bStr[i] = bytes1(uint8(bStr[i]) - 32);
            }
        }
        return string(bStr);
    }
}
