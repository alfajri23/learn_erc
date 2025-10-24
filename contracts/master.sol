// FETokenOz.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Impor kontrak standar yang sudah diaudit
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/access/Ownable.sol";

// Kontrak mewarisi semua fungsi dasar ERC20 dan Ownable
contract FETokenOz is ERC20, Ownable {

    constructor(uint256 initialSupply) 
        ERC20("FE Token", "FE") // Nama dan Simbol
        Ownable()
    {
        uint256 supplyWithDecimals = initialSupply * 10**decimals(); 

        // Fungsi internal OZ untuk mencetak token awal
        _mint(msg.sender, supplyWithDecimals);
    }
    
    // Fungsi untuk menambah suplai (Minting) - Dibatasi hanya untuk pemilik
    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "ERC20: mint ke alamat nol ditolak");
        uint256 amountInSmallestUnit = amount * 10**decimals();
        _mint(to, amountInSmallestUnit);
    }
    
    // Semua fungsi wajib lainnya (transfer, balanceOf, approve, dll.) 
    // sudah diimplementasikan dan aman secara otomatis.
}