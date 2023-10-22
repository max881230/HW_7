// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "../src/HW2_myNFT.sol";

contract NFTTest is Test {
    myNFT public _myNFT;

    address user1 = makeAddr("user1");

    function setUp() public {
        _myNFT = new myNFT();
    }

    function testMint() public {
        vm.startPrank(user1);
        _myNFT.mint(user1);
        assertEq(_myNFT.balanceOf(user1), 1);
        vm.stopPrank();
    }

    function testActivate() public {
        vm.startPrank(user1);
        _myNFT.mint(user1);
        string memory beforeURI = _myNFT.tokenURI(0);
        assertEq(
            beforeURI,
            "https://ipfs.io/ipfs/QmdeubcosWCsUkDSWSPohdKyDRTZZYxZBX61k6597qJRgv"
        );

        _myNFT.activateNFT(0);
        string memory afterURI = _myNFT.tokenURI(0);
        assertEq(
            afterURI,
            "https://ipfs.io/ipfs/QmRQ6Cc9dv6Nk3efw17PtM3z3uu6fjv8z6EguBw2naXWzg"
        );
        vm.stopPrank();
    }
}
