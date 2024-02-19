// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "./IUniswapV2Router.sol";
import "./IPausableERC20.sol";
import "./IPair.sol";


// import "hardhat/console.sol";
/// Error codes
/// E0
/// E1: LP balance not equal to that of user's
/// E2:
/// E3:
/// E4:

import "hardhat/console.sol";

contract LPMigration {

    UniswapV2Router public router;
    // address public lpToken; // Address of the ERC20 LP token
    address public gthToken; // Address of the GTH token

    event Liquidated(
        address sender,
        uint256 lptokenAmount,
        uint256 gthAmount,
        uint256 ethAmount
    );

    constructor(address _router, address _gthToken) {
        router = UniswapV2Router(_router);
        // lpToken = _lpToken;
        gthToken = _gthToken;
    }

    // before calling this function
    // user must call approve function on lptoken to give max allowance (= bal) to this contract.
    //
    function liquidate(address lpToken, uint deadline) external {
        console.log("liquidation started..");
        // uint balance = IPausableERC20(lpToken).balanceOf(msg.sender);
        uint256 lp_bal = IPair(lpToken).allowance(msg.sender, address(this));
        // require(IPair(lpToken).allowance(address(this), msg.sender) >= lp_bal, "E1");
        // this contract gives approval to router
        console.log(lp_bal);
        console.log("[passed] condition 1..");
        
        bool isPaused = IPausableERC20(gthToken).paused();

        if(isPaused) {
            // now unpause the gth token
            IPausableERC20(gthToken).unpause();
        }

        uint gthAmount;
        uint ethAmount;
        (gthAmount, ethAmount) = UniswapV2Router(router).removeLiquidityETH(
            gthToken,
            lp_bal,
            0,
            0,
            address(this), // 'to' address
            deadline
        );
        // check liquidity has been transfered to this contract
        // ETH
        require(ethAmount > 0, "E2");
        // gth
        require(gthAmount > 0, "E3");
        // now pause the gth token again
        IPausableERC20(gthToken).pause();
        // transfer recieved eth to the sender.
        // address(this).send(msg.sender, address(this).balance());
        payable(msg.sender).transfer(address(this).balance); //change as per Nishant Sir's comments
        // UniswapV2Router(uniswapv2Router).removeLiquidityETHWithPermit(GTH,0,0,0,address(this),deadline,true,v,r,s);
        emit Liquidated(msg.sender, lp_bal, gthAmount, ethAmount);
    }

    // get gth tokens out
    // function withdrawgth(
    //     // params...
    // ) {

    // }
}
