// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IPair {

    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);



}
