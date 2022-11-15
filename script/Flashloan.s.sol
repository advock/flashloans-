// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Script.sol";
import "../src/Flashloan.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Flashloan flashloan = new Flashloan(
            0xc4dCB5126a3AfEd129BC3668Ea19285A9f56D15D
        );

        vm.startBroadcast();
    }
}
