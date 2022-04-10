// SPDX-License-Identifier: MIT
import "./Allowance.sol";

pragma solidity ^0.8.11;

contract SimpleWallet is Allowance{

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    event GetBalance(uint _currentBalance);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount){
     
        require(_amount <= address(this).balance,"Insufficient funds!");
        if(msg.sender != owner()){
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(msg.sender, _amount);
        _to.transfer(_amount);
        getBalance();
    }

    function renounceOwnership() override view public onlyOwner{
        revert("Can't renounce ownership!");
    }
    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
        getBalance();
    }

    function getBalance() public{
        emit GetBalance(address(this).balance);
    }
 
}