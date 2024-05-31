// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract SeatBooking {
    uint constant TOTAL_SEATS = 20;
    uint constant MAX_TICKETS_PER_ADDRESS = 4;
    mapping(uint => address) public seatToOwner;
    mapping(address => uint[]) public ownerToSeats;

    modifier validSeatNumbers(uint[] memory seatNumbers) {
        require(seatNumbers.length > 0 && seatNumbers.length <= MAX_TICKETS_PER_ADDRESS, "Invalid number of seats");
        for (uint i = 0; i < seatNumbers.length; i++) {
            require(seatNumbers[i] > 0 && seatNumbers[i] <= TOTAL_SEATS, "Seat number out of range");
            require(seatToOwner[seatNumbers[i]] == address(0), "Seat already booked");
        }
        _;
    }

    function bookSeats(uint[] memory seatNumbers) public validSeatNumbers(seatNumbers) {
        require(ownerToSeats[msg.sender].length + seatNumbers.length <= MAX_TICKETS_PER_ADDRESS, "Max 4 tickets per address");

        for (uint i = 0; i < seatNumbers.length; i++) {
            uint seatNumber = seatNumbers[i];
            seatToOwner[seatNumber] = msg.sender;
            ownerToSeats[msg.sender].push(seatNumber);
        }
    }

    function showAvailableSeats() public view returns (uint[] memory) {
        uint[] memory availableSeats = new uint[](TOTAL_SEATS);
        uint count = 0;
        for (uint i = 1; i <= TOTAL_SEATS; i++) {
            if (seatToOwner[i] == address(0)) {
                availableSeats[count] = i;
                count++;
            }
        }

        uint[] memory result = new uint[](count);
        for (uint i = 0; i < count; i++) {
            result[i] = availableSeats[i];
        }
        return result;
    }

    function checkAvailability(uint seatNumber) public view returns (bool) {
        require(seatNumber > 0 && seatNumber <= TOTAL_SEATS, "Seat number out of range");
        return seatToOwner[seatNumber] == address(0);
    }

    function myTickets() public view returns (uint[] memory) {
        return ownerToSeats[msg.sender];
    }
}