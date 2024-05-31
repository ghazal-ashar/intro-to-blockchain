// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Factorial {
    
    // Function to calculate factorial of a number
    function calculateFactorial(uint256 n) public pure returns (uint256) {
        uint256 f = 1;
        for (uint256 i = 1; i <= n; i++) {
            f *= i;
        }
        return f;
    }
}