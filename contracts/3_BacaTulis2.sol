// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./UppercaseString.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract BacaTulis2 {

    string myName;

    UppercaseString us = new UppercaseString();

    function setName(string calldata name) public {
        myName = name;
    }

    function getName() public view returns (string memory) {
        return us.toUpperCase(myName);
    }
}



