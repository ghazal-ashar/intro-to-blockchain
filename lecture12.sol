// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lecture12{
    // uint public count;
    // mapping(address=>uint) public counter;
    
    // function addCounter() public {
    //     counter[msg.sender]=count;
    // }

    // mapping (address=> uint) public payment;
   
    // function addPayment()public payable {
    //     require(msg.value >= 2 ether,"Insufficient payment");
    //     payment[msg.sender]=msg.value;
    // }

    mapping (address=> uint) public payment;
   
    // function addPayment()public payable {
    //     require(address(this).balance <= 10 ether,"Balance exceeding 10 Ethers.");
    //     require(msg.value >= 2 ether,"Insufficient payment");
    //     payment[msg.sender]=msg.value;
    // }

    uint totalValue;

    address public owner = msg.sender;

    modifier onlyOwner(){
        require(msg.sender == owner, "Not the owner");
        _;
    }
    
    mapping (address => bool) public isTrue;
    modifier _isTrue(){
        require(!isTrue[msg.sender],"Already Set.");
        _;
    }

    function addPay() public payable  onlyOwner _isTrue{
        //require(totalValue <=10 ether,"Exceeding 10 ethers");
        payment[msg.sender] += msg.value;
        totalValue = address(this).balance;
        isTrue[msg.sender]=true;
    }


}