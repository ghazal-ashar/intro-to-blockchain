// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Auction {
    address public owner;

    struct Item {
        uint startingPrice;
        bool active;
    }

    mapping(uint => Item) public items;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createAuction(uint itemNumber, uint startingPrice) public onlyOwner {
        require(startingPrice > 0, "Starting price must be greater than 0");
        items[itemNumber] = Item(startingPrice, true);
    }

    function bid(uint itemNumber) public payable {
        require(items[itemNumber].active, "Auction is not available");
        require(msg.value == items[itemNumber].startingPrice, "Same price");
        payable(owner).transfer(msg.value);
        items[itemNumber].active = false;
    }


    function checkAuctionActive(uint itemNumber) public view returns(bool) {
        return items[itemNumber].active;
    }

    function checkAuctionPrice(uint itemNumber) public view returns(uint256) {
       return items[itemNumber].startingPrice;
    }

}