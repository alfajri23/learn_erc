// Forwarder.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// Import kontrak MinimalForwarder dari OpenZeppelin
import "@openzeppelin/contracts/metatx/MinimalForwarder.sol";

// Kontrak ini mewarisi semua logika verifikasi tanda tangan dan nonce
contract MyForwarder is MinimalForwarder {
    // Tidak perlu menambahkan kode di dalam body. 
    // Semua yang diperlukan (execute, verify, nonces) sudah diwariskan.
}