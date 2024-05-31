// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Lottery {
    address public owner;
    uint public constant ENTRY_FEE = 1 ether;
    uint public constant MAX_PLAYERS = 5;
    
    address[] public participants;
    uint public numberOfParticipants;

    constructor() {
        owner = msg.sender;
    }

    function enter() public payable {
        require(msg.value == ENTRY_FEE, "Incorrect entry fee");
        require(numberOfParticipants < MAX_PLAYERS, "Lottery pool is full");
        require(!isParticipant(msg.sender), "Player already entered the lottery");

        participants.push(msg.sender);
        numberOfParticipants++;

    }

    function viewParticipants() public view returns (address[] memory, uint) {
        return (participants, numberOfParticipants);
    }


    function selectWinner() public {
        uint index = random() % MAX_PLAYERS;
        payable(participants[index]).transfer(address(this).balance);
    }

    function clearPool() public {
        delete participants;
        numberOfParticipants = 0;
    }

    function isParticipant(address _address) private view returns (bool) {
        for (uint i = 0; i < participants.length; i++) {
            if (participants[i] == _address) {
                return true;
            }
        }
        return false;
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants.length)));
    }

    receive() external payable {
        enter();
    }
}