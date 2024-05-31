// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract EvenChecker {
    
    // Function to check if a number is even
    function isEven(uint256 number) public pure returns (bool) {
        return number % 2 == 0;
    }
}