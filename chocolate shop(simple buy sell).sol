// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract ChocolateShop {

    uint private chocolateBag;
    int[] private transactions;

    constructor() {
        chocolateBag = 0;
    }

    function buyChocolates(uint n) public {
        require(n > 0, "Number of chocolates to buy should be greater than zero");
        chocolateBag += n;
    }

    function sellChocolates(uint n) public {
        require(n > 0, "Number of chocolates to sell should be greater than zero");
        require(chocolateBag >= n, "Not enough chocolates in the bag to sell");
        chocolateBag -= n;
    }

    function chocolatesInBag() public view returns (uint) {
        return chocolateBag;
    }

    function showTransaction(uint n) public view returns (int txn) {
        require(n < transactions.length, "Transaction does not exist");
        return transactions[n];
    }

    function numberOfTransactions() public view returns (uint n) {
        return transactions.length;
    }
}