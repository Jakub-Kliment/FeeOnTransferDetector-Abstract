// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {FeeOnTransferDetector} from "../../src/FeeOnTransferDetector.sol";

// Recommended to deploy using foundry create if address not important
contract DeployFOTDetector is Script {
    address private constant V2_FACTORY = 0x566d7510dEE58360a64C9827257cF6D0Dc43985E;

    function setUp() public {}

    function run() public {
        vm.broadcast();
        address detector = address(new FeeOnTransferDetector{salt: 0x00}(V2_FACTORY));

        // bytes32 initCodeHash = 0x00;
        // bytes32 ctorHash = keccak256(abi.encode);
        // bytes32 salt = 0x00 ;
        // bytes32 hash = keccak256(
        //     abi.encodePacked(
        //     keccak256("zksyncCreate2"),
        //     bytes32(uint(uint160(address(this)))),
        //     salt,
        //     initCodeHash,
        //     ctorHash
        //     )
        // );
        // address expected = address(uint160(uint256(hash)));

        console2.log("Successfully deployed", detector);
    }
}
