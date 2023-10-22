// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "../src/HW2_myNFT.sol";

contract NFTTest is Test {
    myNFT public _myNFT;

    address user1 = makeAddr("user1");

    function setUp() public {
        vm.roll(0);
        _myNFT = new myNFT();
    }

    function testMint() public {
        vm.startPrank(user1);
        _myNFT.mint(user1);
        assertEq(_myNFT.balanceOf(user1), 1);
        vm.stopPrank();
    }

    function testActivateFail() public {
        vm.startPrank(user1);
        // 根據我activate的規則：block number > activationTime = block.number + 30;
        // 不去設定 blocknumber 導致不行 activate
        _myNFT.mint(user1);
        vm.expectRevert("you can't activate the NFT before activation time");
        _myNFT.activateNFT(0);
        vm.stopPrank();
    }

    function testActivateSuccess() public {
        vm.startPrank(user1);
        // 根據我activate的規則：block number > activationTime = block.number + 30; 設定當前的block number 為31
        vm.roll(31);
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
