//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract A {
    uint[] public amounts;
    function init(uint[] memory _amounts) public{
        amounts = _amounts;
    }
}

contract Factory {
    struct AData {
        uint[] amounts;
    }
    mapping (address => AData) listOfData;

    function set(uint[] memory _amounts) public{
        listOfData[msg.sender] = AData(_amounts);
    }

    function make() public returns(address) {
        A a = new A();
        a.init(listOfData[msg.sender].amounts);
        return address(a);
    }
}