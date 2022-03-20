//SPDX-License-Identifier: GPL-3.0

pragma solidity  ^0.8.0;

contract IDO{

    address [] public whiteList;
    mapping(address=>bool) public whiteListMapping;
    address [] public contributor1;
    address [] public contributor2;
    address public manager ; 
    address public deposit;

    uint public hardcap = 1000 ether;
    uint public raiseAmount =0;
    uint public count =0;
    uint public canBuy =0;

    constructor(address _deposit , address [] memory initWhitelist)
    {
        manager = msg.sender;
        deposit = _deposit;
        whiteList = initWhitelist;
    }

    modifier onlyAdmin(){
        require(msg.sender == manager);
        _;
    }

    function isWhitelist(address check) public view returns(uint)
    {
        if(whiteListMapping[check]) return 1;
        return 0;
    }

    function changeStatus() public onlyAdmin returns(bool)
    {
         if(canBuy ==0)
        {
            canBuy =1;
            for(uint i =0;i<whiteList.length ;i++)
            {
                whiteListMapping[whiteList[i]] = true;
            }
          
        }
        else if(canBuy ==1) canBuy =0;
        return true;
    }

    function enter() public payable returns(bool)
    {
        require(canBuy ==1 ,"Can't buy");
        require( whiteListMapping[msg.sender] == true ,"You are not in whitelist");
        require(msg.value == 1 ether,"Don't enough 1 BNB");

        if(count <= 400)
        {
            contributor1.push(msg.sender);    
        }
        else 
        {
            contributor2.push(msg.sender);    
        }
      

         payable(deposit).transfer(msg.value);
         raiseAmount += 1 ether;

        return true;
    }

    function getWhiteList() public onlyAdmin view returns(address[] memory)  {
        return whiteList;
    }

    function getContributor1() public onlyAdmin view returns(address[] memory)  {
        return contributor1;
    }

    function getContributor2() public onlyAdmin view returns(address[] memory)  {
        return contributor2;
    }

}