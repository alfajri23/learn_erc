// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract NakedToken {
    mapping ( address => uint ) public balances;

    mapping(address => mapping(address => uint256)) public allowance;

    string public constant name = "FE Token Basic";
    string public constant symbol = "FE";

    uint256 private _totalSupply;
    
    constructor(uint256 initialSupply) {
        _totalSupply = initialSupply * 10**18;
        balances[msg.sender] = _totalSupply;
    }

    function balanceOf(address account) public view returns(uint256){
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) public returns (bool){
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        return true;
    } 

    function approve(address spender, uint256 amount) public returns (bool){
        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool){
        require(allowance[sender][msg.sender] >= amount, "Batas pengeluaran terlampaui");
        require(balances[sender] >= amount, "Saldo pengirim tidak mencukupi");

        // Perbarui buku besar dan kurangi izin
        balances[sender] -= amount;
        balances[recipient] += amount;
        allowance[sender][msg.sender] -= amount;

        return true;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

}