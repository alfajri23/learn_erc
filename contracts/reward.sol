// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RewardToken is ERC20, ERC2771Context, Ownable {
    address private immutable FORWARDER_ADDRESS;

    constructor(address trustedForwarder, address initialOwner)
        ERC20("Reward Token", "RWD")
        ERC2771Context(trustedForwarder)
        Ownable(initialOwner)
    {
        FORWARDER_ADDRESS = trustedForwarder;
    }

    // Tambahkan fungsi override ini
    function _contextSuffixLength() 
        internal 
        view 
        override(ERC2771Context, Context) 
        returns (uint256) 
    {
        return super._contextSuffixLength();
    }

    function _msgSender() 
        internal 
        view 
        override(ERC2771Context, Context) 
        returns (address) 
    {
        return super._msgSender();
    }

    function _msgData() 
        internal 
        view 
        override(ERC2771Context, Context) 
        returns (bytes calldata) 
    {
        return super._msgData();
    }

    function isTrustedForwarder(address forwarder)
        public 
        view 
        override(ERC2771Context)
        returns (bool) 
    {
        return super.isTrustedForwarder(forwarder);
    }

    function mint(address account, uint256 amount) public onlyOwner {
        uint256 amountInSmallestUnit = amount * 10**decimals();
        _mint(account, amountInSmallestUnit);
    }

    function increaseSupply(uint256 amount) public onlyOwner {
        uint256 amountInSmallestUnit = amount * 10**decimals();
        _mint(owner(), amountInSmallestUnit);
    }
}
