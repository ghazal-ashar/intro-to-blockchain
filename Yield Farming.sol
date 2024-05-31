// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract YieldFarming {
    struct Pool {
        uint maxAmount;
        uint yieldPercent;
        uint minDeposit;
        uint rewardTime;
        uint lastRewardTime;
        mapping(address => uint) deposits;
        mapping(address => uint) lastClaimTime;
    }

    struct Whale {
        bool exists;
        uint amount;
    }

    address public owner;
    Pool[] public pools;
    mapping(address => uint) public whaleWallets;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(address _tokenAddress) {
        owner = msg.sender;
    }

    function addPool(uint _maxAmount, uint _yieldPercent, uint _minDeposit, uint _rewardTime) public onlyOwner {
          pools.push(Pool(_maxAmount, _yieldPercent, _minDeposit, _rewardTime, block.timestamp));
    }

    function depositWei(uint _poolId) public payable {
        require(_poolId < pools.length, "Invalid pool ID");
        require(block.timestamp >= pools[_poolId].lastRewardTime + pools[_poolId].rewardTime, "Reward time not reached");
        require(msg.value >= pools[_poolId].minDeposit, "Deposit amount is less than minimum");
        require(pools[_poolId].deposits[msg.sender] == 0, "User already deposited in this pool");

        if (msg.value >= 10000) {
            whaleWallets[msg.sender] += msg.value;
        }

        pools[_poolId].deposits[msg.sender] = msg.value;
    }

    function withdrawWei(uint _poolId, uint _amount) public {
        require(_poolId < pools.length, "Invalid pool ID");
        require(pools[_poolId].deposits[msg.sender] >= _amount, "Insufficient balance");

        pools[_poolId].deposits[msg.sender] -= _amount;
        msg.sender.transfer(_amount);
    }

    function checkPoolDetails(uint _poolId) public view returns (uint, uint, uint, uint) {
        require(_poolId < pools.length, "Invalid pool ID");

        Pool memory pool = pools[_poolId];
        return (pool.maxAmount, pool.yieldPercent, pool.minDeposit, pool.rewardTime);
    }

    function checkUserDeposits(address _user) public view returns (uint, uint) {
        uint totalDeposit;
        uint totalRewards;

        for (uint i = 0; i < pools.length; i++) {
            totalDeposit += pools[i].deposits[_user];
        }

        return (totalDeposit, totalRewards);
    }
}