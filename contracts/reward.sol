// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RewardToken is ERC20, ERC2771Context, Ownable {
    address private immutable FORWARDER_ADDRESS;

    constructor(address trustedForwarder, address initialOwner, uint256 initialSupply)
        ERC20("Reward 1 Token", "RWD 1")
        ERC2771Context(trustedForwarder)
        Ownable(initialOwner)
    {
        uint256 supply = initialSupply * 10**decimals();
        FORWARDER_ADDRESS = trustedForwarder;
        _mint(owner(), supply);
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

    function convertAmount(uint256 amount) private view returns (uint256) {
        return amount * 10**decimals();
    }

    function increaseSupply(uint256 amount) public onlyOwner {
        uint256 amountInSmallestUnit = convertAmount(amount);
        _mint(owner(), amountInSmallestUnit);
    }

    function claimReward(uint256 amount) public {
        require(
            isTrustedForwarder(msg.sender) || _msgSender() == owner(), 
            "RewardToken: Must use a Trusted Forwarder or be the Owner."
        );

        uint256 rewardAmount = convertAmount(amount);
        _transfer(owner(), _msgSender(), rewardAmount);
    }

    function claimRewardPublic(address user_address, uint256 amount) public onlyOwner {
        require(user_address != address(0), "New wallet cannot be the zero address");
        address sender = msg.sender;

        uint256 rewardAmount = convertAmount(amount);

        _transfer(sender, user_address, rewardAmount);
    }

    function decreaseMyToken(uint256 amount) public {
        require(
            isTrustedForwarder(msg.sender) || _msgSender() == owner(), 
            "RewardToken: Must use a Trusted Forwarder or be the Owner."
        );

        uint256 rewardAmount = convertAmount(amount);
        _transfer(_msgSender(), owner(), rewardAmount);
    }

    function decreaseMyTokenPublic(address user_address, uint256 amount) public {
        require(user_address != address(0), "New wallet cannot be the zero address");
        address sender = msg.sender;

        uint256 rewardAmount = convertAmount(amount);
        _transfer(user_address, sender, rewardAmount);
    }
}
