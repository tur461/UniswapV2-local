// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface UniswapV2Router {
  function removeLiquidityETH(
    address token,
    uint liquidity,
    uint amountTokenMin,
    uint amountETHMin,
    address to,
    uint deadline
  
) external returns (uint amountToken, uint amountETH);
}
