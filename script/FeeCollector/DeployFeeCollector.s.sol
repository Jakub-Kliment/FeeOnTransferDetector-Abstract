// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {FeeCollector} from "../../src/FeeCollector.sol";

struct DeployParameters {
    address owner;
    address universalRouter;
    address permit2;
    address feeToken;
}

abstract contract DeployFeeCollector is Script {
    DeployParameters internal params;

    //address public constant OWNER = ;
    address constant PERMIT2 = 0x0000000000225e31D15943971F47aD3022F714Fa;
    address constant UNIVERSAL_ROUTER = 0xE1b076ea612Db28a0d768660e4D81346c02ED75e;

    // For mainnet parameters, deploys the FeeCollector to 0x000000fee13a103A10D593b9AE06b3e05F2E7E1c
    bytes32 constant SALT = bytes32(uint256(0x0000000000000000000000000000000000000000e6a691a183251100795200f0));

    function setUp() public virtual {}

    function run() public returns (FeeCollector collector) {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        // require all parameters to be set
        require(params.owner != address(0), "owner not set");
        require(params.universalRouter != address(0), "universalRouter not set");
        require(params.permit2 != address(0), "permit2 not set");
        require(params.feeToken != address(0), "feeToken not set");

        vm.startBroadcast(privateKey);
        collector = new FeeCollector{salt: SALT}(params.owner, params.universalRouter, params.permit2, params.feeToken);
        vm.stopBroadcast();

        console2.log("Successfully deployed FeeCollector", address(collector));
        console2.log("owner", collector.owner());
    }

    function logParams() internal view {
        console2.log("permit2:", params.permit2);
        console2.log("feeToken:", params.feeToken);
        console2.log("universalRouter:", params.universalRouter);
        console2.log("owner:", params.owner);
    }
}
