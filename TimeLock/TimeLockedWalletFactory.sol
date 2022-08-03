// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TimeLockedWallet.sol";

contract TimeLockedWalletFactory {

    mapping(address => address[]) public ownerToWallets;

    function getWalletsOfAddress(address _walletsToView) 
        public view 
        returns(address[] memory _walletsOfAddress) 
    {
        return ownerToWallets[_walletsToView];
    }

    function getWalletsOfSender() 
        public view 
        returns(address[] memory _walletsOfAddress) 
    {
        return ownerToWallets[msg.sender];
    }

    function newWallet(uint256 _unlockDate) payable public returns(address _a)
    {
        TimeLockedWallet _newWallet = new TimeLockedWallet(_unlockDate, msg.sender);
        address payable _newPayableAddress = payable(address(_newWallet));

        ownerToWallets[msg.sender].push(address(_newWallet));
        _newPayableAddress.transfer(msg.value);

        return address(_newWallet);
    }


    receive() external payable {
        revert();
    }

    fallback() external payable {
        revert();
    }

}