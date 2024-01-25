// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Victim is ReentrancyGuard{
    
    mapping(address => uint) public balances;

    constructor() payable {}

    function deposit() external payable{
        balances[msg.sender] += msg.value;
    }

    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }

    function withdraw() nonReentrant external payable returns(bool status) {
        // Check
        require(balances[msg.sender] > 0, "not enough balance!");

        // Effect 
        balances[msg.sender] = 0;

        // Interaction
        (status, ) = payable(msg.sender).call{value: balances[msg.sender]}("");      

    }
}

