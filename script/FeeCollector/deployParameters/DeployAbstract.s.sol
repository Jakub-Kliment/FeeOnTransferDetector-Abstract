// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {DeployFeeCollector, DeployParameters} from "../DeployFeeCollector.s.sol";

address constant WETH = 0x3439153EB7AF838Ad19d56E1571FBD09333C2809;

contract DeployAbstract is DeployFeeCollector {
    function setUp() public override {
        params = DeployParameters({
            owner: OWNER,
            universalRouter: UNIVERSAL_ROUTER,
            permit2: PERMIT2,
            feeToken: WETH
        });
    }
}
