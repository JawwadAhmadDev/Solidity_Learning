//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Car {
    string public name;
    address public creator;
    address public initializer;
    uint public sentValue;

    constructor(string memory _name) payable{
        name = _name;
        creator = msg.sender;
        initializer = tx.origin;
        sentValue = msg.value;
    }
}



contract Factory {
    Car[] public cars;
    function createCar (string memory _name) external payable {
        Car car = new Car{value: msg.value}(_name);
        cars.push(car);
    }
}