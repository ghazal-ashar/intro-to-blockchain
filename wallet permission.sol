// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Wallet {
    address public owner;
    uint public balance;
    uint public constant MAX_BALANCE = 10000;
    mapping(address => bool) private accessList;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier hasAccess() {
        require(accessList[msg.sender], "You do not have access to this wallet");
        _;
    }

    constructor() {
        owner = msg.sender;
        balance = 0;
        accessList[owner] = true;
    }

    function addFunds(uint amount) public hasAccess {
        require(balance + amount <= MAX_BALANCE, "Cannot exceed maximum wallet balance");
        balance += amount;
    }

    function spendFunds(uint amount) public hasAccess {
        require(balance >= amount, "Insufficient funds");
        balance -= amount;
    }

    function addAccess(address x) public onlyOwner {
        accessList[x] = true;
    }

    function revokeAccess(address y) public onlyOwner {
        accessList[y] = false;
    }

    function viewBalance() public view hasAccess returns (uint) {
        return balance;
    }
}