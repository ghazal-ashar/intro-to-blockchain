// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract CryptoExchange {
    mapping(address => uint256) public balances;

    // Event for logging deposits
    event Deposit(address indexed user, uint256 amount);

    // Event for logging withdrawals
    event Withdrawal(address indexed user, uint256 amount);

    // Event for logging buys
    event Buy(address indexed user, uint256 amount);

    // Deposit Ether into the contract
    function deposit() public payable {
        require(msg.value > 0, "You need to deposit some amount of Ether");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Buy function to simulate buying crypto (simply increasing balance)
    function buy() public payable {
        require(msg.value > 0, "You need to send some Ether to buy");
        balances[msg.sender] += msg.value;
        emit Buy(msg.sender, msg.value);
    }

    // Withdraw Ether from the contract
    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    // Check balance of the sender
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}