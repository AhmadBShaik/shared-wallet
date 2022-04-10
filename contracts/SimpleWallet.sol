// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract SimpleWallet {
    
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not the owner!");
        _;
    }
    function withdrawMoney(address payable _to, uint _amount) public onlyOwner{
        _to.transfer(_amount);
    }

    receive() external payable {
        
    }
}