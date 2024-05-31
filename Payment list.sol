// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract SimplePaymentChannel {
    address public owner;
    address public recipient;
    uint public depositedAmount;
    uint[] public payments;

    constructor(address _recipientAddress) {
        owner = msg.sender;
        recipient = _recipientAddress;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        depositedAmount += msg.value;
    }

    function listPayment(uint256 _amount) public {
        require(_amount <= depositedAmount, "Listed amount exceeds deposited amount");
        payments.push(_amount);
    }

    function closeChannel() public {
        require(msg.sender == owner || msg.sender == recipient, "Only the owner or recipient can close the channel");

        if (msg.sender == owner) {
            payable(owner).transfer(address(this).balance);
        } else {
            payable(recipient).transfer(address(this).balance);
        }
    }

    function checkBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getAllPayments() public view returns (uint[] memory) {
        return payments;
    }
}