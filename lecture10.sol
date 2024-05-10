// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lecture10{

    // function mod(uint a, uint b) public pure returns(uint){
    //     return a%b ;
    // }

    // function compare(uint a, uint b) public pure returns(bool){
    //     if(a>=b)
    //     return true;
    //     else 
    //     return false;
    //     }

    // function acceptEthers() public payable returns(uint256){
    //     return msg.value;
    // }

    // function withdrawEthers() public {
    //     address owner = msg.sender;
    //     payable(owner).transfer(address(this).balance);
    // }

    //transfer directly to an account
    // function acceptEthers() public payable {
    //     address owner = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    //     payable(owner).transfer(address(this).balance);
    // }

    //tx.origin intiates transaction for the first time

//     function returnArray() public pure returns (uint[] memory){
//         uint[] memory array = new uint[](5);
        
//         for(uint i=0; i<5; i++){
//             array[i]=i;
//         }
//         return array;
//     }

        // function returnVal(uint a, uint b, uint c) public pure returns(uint, uint, uint){
        //     return (a, b, c);
        // }

    
}
