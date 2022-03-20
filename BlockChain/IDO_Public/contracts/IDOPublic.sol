//SPDX-License-Identifier: GPL-3.0

pragma solidity  ^0.8.0;

contract IDOPublic{
    address [] public contributor;
    address public manager ; 
    address public deposit;

    uint public hardcap = 300 ether;
    uint public raiseAmount =0;

    uint public canBuy =0;

    constructor(address _deposit )
    {
        manager = msg.sender;
        deposit = _deposit;      
    }

    modifier onlyAdmin(){
        require(msg.sender == manager);
        _;
    }

    function changeStatus() public onlyAdmin returns(bool)
    {
        if(canBuy ==1) canBuy =0;
        else if(canBuy ==0) canBuy =1;
        return true;
    }

    function enter() public payable returns(bool)
    {
        require(canBuy ==1 ,"Can't buy");
        require(raiseAmount < hardcap ,"Enough hardcap ");
        require(msg.value == 1 ether,"Don't enough 1 BNB");
        contributor.push(msg.sender);

         payable(deposit).transfer(msg.value);
         raiseAmount += 1 ether;
         
        return true;       
    }


    function getContributor() public onlyAdmin view returns(address[] memory)  {
        return contributor;
    }

}