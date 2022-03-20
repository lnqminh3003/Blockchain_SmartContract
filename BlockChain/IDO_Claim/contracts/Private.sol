//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.12;

import "./MinhToken.sol";

contract Private{
    address public manager;
    AuraToken public tokenContract;

    address [] public privateGroup;
    uint public firstTGE =3000 * 10**18;
    uint public laterTGE =2000 * 10**18;
    bool public firstTime = true;
    
    address public deposit ;

    constructor(address _deposit,AuraToken _tokenContract,  address [] memory _privateGroup)
    {
        deposit = _deposit;
        manager = msg.sender;
        tokenContract= _tokenContract;
        privateGroup = _privateGroup;
    }

       modifier onlyAdmin(){
        require(msg.sender == manager);
        _;
    }

    function getTokenContract() public onlyAdmin view returns(AuraToken)
    {
        return tokenContract;
    }

    function getPrivateGroup() public onlyAdmin view returns(address[] memory)
    {
        return privateGroup;
    }

    function burnCoin(uint amount) public onlyAdmin{
        tokenContract.transfer(deposit , amount *10 **18);  
    }

    function transferCoinToPrivate() public onlyAdmin returns(bool)
    {
        if(firstTime == true)
        {
            for (uint i =0;i< privateGroup.length;i++)
            {
                tokenContract.transfer(privateGroup[i], firstTGE);
            }
            firstTime = false;
        }
        else 
        {
            for (uint i =0;i< privateGroup.length;i++)
            {
                tokenContract.transfer(privateGroup[i], laterTGE);
            }
        }

        return true;
    }

}