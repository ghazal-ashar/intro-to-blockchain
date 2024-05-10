// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract bank{
    address public owner = msg.sender;

    mapping(address => uint) public balances;
    modifier onlyOwner(){
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function getBalance() public view onlyOwner returns (uint)  {
        return balances[msg.sender];
    }

    function deposit() public payable {
        require(msg.value > 0, "Amount shoudl be greater than 0");
        balances[msg.sender] += msg.value;

    }

    function withdraw(uint amount)  public onlyOwner{
        require(amount > 0, "Amount shoudl be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
    }
    
}