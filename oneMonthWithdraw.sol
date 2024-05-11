// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract assignment{

     address public owner = msg.sender;

     mapping(address => uint) public deposits;
     mapping(address => uint) public depositTime;

     event dep(address _owner, uint depositAmount, string message);
     event withdrawal(address _owner, uint withdrawAmount, string _message);
    
    modifier afterOneMonth(address _account) {
        require(block.timestamp >= depositTime[_account] + 30 days, "Withdrawal not allowed before one month");
        _;
    }
    
    function deposit() public payable {
        require(msg.value > 0, "Amount should be greater than 0");
        deposits[msg.sender] += msg.value;
        depositTime[msg.sender] = block.timestamp;
        emit dep(owner, msg.value, "successfully deposited");
    }

     function withdraw(uint _amount) public afterOneMonth(msg.sender) {
        require(_amount > 0, "Amount should be greater than 0");
        require(deposits[msg.sender] >= _amount, "Insufficient balance");
        payable(msg.sender).transfer(_amount);
        deposits[msg.sender] -= _amount;
        emit withdrawal(msg.sender, _amount, "Successfully withdrawn");
    }

}