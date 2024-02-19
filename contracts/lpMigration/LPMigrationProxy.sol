// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
// import "hardhat/console.sol";

contract LPMigrationProxy is TransparentUpgradeableProxy {
    constructor(address _logic, address _admin, bytes memory _data)
        TransparentUpgradeableProxy(_logic, _admin, _data)
    {}
}
