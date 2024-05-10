// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lecture11{

//     enum levels{FAIL, AVERAGE, PASS}//returns 0 for first, 1 for second and so on
//     levels _level = levels.FAIL;
//     levels _level2 = levels.PASS;

// //enum uses constants, uint
//     function getEnum()public view returns(levels, levels){
//         return (_level, _level2);
//     }

    // struct studentdata{
    //     uint RegNo;
    //     string name;
    // }
    // studentdata student;
    // function setData()public{
    //     student= studentdata(2,"Ghazal");

    // }
    // function getstruct() public view returns(string memory, string memory){
    //     return student.name, student.RegNo;

    // }

//     uint256[] arr;

//     function getArray() public returns (uint[] memory){
//         uint256[] memory _arr = new uint256[](5);
//         for(uint i=0; i<5; i++){
//             _arr[i] = i;
//         }
//         arr = _arr;
//         return _arr;
//     }

//     function getGlobalArray() public view returns (uint256[] memory){
//         return arr;
//     }

    mapping (address=> uint) balances;

        function setBalance()public {
            balances[msg.sender]=500;

        }
        function getBalance()public view returns(uint){
            return balances[msg.sender];
        }
        function getBalance(address _addr) public view returns (uint){
            return balances[_addr];
        }

}
