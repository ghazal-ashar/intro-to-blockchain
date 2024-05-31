// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract OwnerContract {
    
    address private owner;

    // Constructor to set the contract deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to get the owner address
    function getOwner() public view returns (address) {
        return owner;
    }
}





