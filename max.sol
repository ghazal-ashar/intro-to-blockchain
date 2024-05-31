// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract MaxNumberFinder {
    
    // Function to find the maximum number in an array
    function findMaxNumber(uint256[] memory numbers) public pure returns (uint256) {
        require(numbers.length > 0, "Array must not be empty");

        uint256 max = numbers[0];
        for (uint256 i = 1; i < numbers.length; i++) {
            if (numbers[i] > max) {
                max = numbers[i];
            }
        }
        return max;
    }
}