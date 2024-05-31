// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Storage {
    uint256 private value;

    // Function to store a value
    function storeValue(uint256 _newValue) public {
        value = _newValue;
    }

    // Function to read the stored value
    function readValue() public view returns (uint256) {
        return value;
    }
}