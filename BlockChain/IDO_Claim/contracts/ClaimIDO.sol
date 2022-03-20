//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.12;

import "./MinhToken.sol";

contract ClaimIDO{
    
    address public deposit;
    AuraToken public tokenContract;
    address[] public contributors;


    address public manager ;
    mapping(address => bool) public contributorsMapping;
    uint public canClaim =0;
    uint256 public firstTGE  = 2000*10**18;
    uint256 public laterTGE = 500*10**18;
    bool public firstClaim = true;
   

     constructor( address _deposit,AuraToken _tokenContract , address[] memory _contributors)
        {
            deposit =_deposit;
            manager = msg.sender;
            tokenContract = _tokenContract;         
            contributors = _contributors;
        }


    modifier onlyAdmin(){
        require(msg.sender == manager);
        _;
    }

    function getTokenContract() public onlyAdmin view returns(AuraToken)
    {
        return tokenContract;
    }

    function getContributors() public onlyAdmin view returns(address[] memory)
    {
        return contributors;
    }



    function isWhitelist(address check) public view returns(uint)
    {
        if(contributorsMapping[check] == true) return 1;
        else return 0;
    }

    function initSetIDO () public onlyAdmin{
        for(uint i =0 ;i< contributors.length ;i++)
        {
            contributorsMapping[contributors[i]] = true;
        }  
    }

    function resetClaim() public onlyAdmin{
        if(canClaim ==0)
        {
            canClaim =1;   
        }
        else 
        {
            firstClaim = false;
            for(uint i =0 ;i< contributors.length ;i++)
            {
            contributorsMapping[contributors[i]] = true;
            } 
        }
    }

    function burnCoin(uint amount) public onlyAdmin{
         tokenContract.transfer(deposit , amount *10**18 );  
    }

    function claim() public returns(bool)
    {
        require(canClaim ==1,"Can't claim");
        require(contributorsMapping[msg.sender] == true , "Can't claim");   
        
        if(firstClaim == true)
        {
            tokenContract.transfer(msg.sender , firstTGE);                     
        }
        else{
            tokenContract.transfer(msg.sender , laterTGE);
        }

        contributorsMapping[msg.sender] = false;

        return true;
    }


       
       
}
