// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NFTSales {
    address public payer;
    address public payee;
    uint public amount;

    constructor(address _payee) payable {
        payer = msg.sender;
        payee = _payee;
        amount = msg.value;
    }

    function release() public {
        require(msg.sender == payer, "Only payer can release");
        payable(payee).transfer(amount);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}