// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract sendEthers{
      function sendEth(address to) public payable {
        require(to != address(this), "Cannot send ETH to this contract");
        payable(to).transfer(msg.value);
    }
}
