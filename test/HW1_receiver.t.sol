// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import "../src/HW1_receiver.sol";

contract ReceiverTest is Test {
    NoUseful public _NoUseful;
    HW_Token public _HW_Token;
    NFTReceiver public _NFTReceiver;

    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");

    function setUp() public {
        _NoUseful = new NoUseful();
        _HW_Token = new HW_Token();
        _NFTReceiver = new NFTReceiver();
    }

    function testMintNoUseful() public {
        vm.startPrank(user1);
        _NoUseful.mint(user1);
        assertEq(_NoUseful.ownerOf(0), user1);
        vm.stopPrank();
    }

    function testReceiveNoUseful() public {
        vm.startPrank(user1);
        _NoUseful.mint(user1);
        address beforeOwnerOf = _NoUseful.ownerOf(0);
        _NoUseful.safeTransferFrom(user1, address(_NFTReceiver), 0);
        address afterOwnerOf = _NoUseful.ownerOf(0);
        assertEq(beforeOwnerOf, afterOwnerOf);
        vm.stopPrank();
    }

    function testReceiveHWToken() public {
        vm.startPrank(user1);
        _NoUseful.mint(user1);
        uint beforeBalanceOf = _HW_Token.balanceOf(user1);
        _NoUseful.safeTransferFrom(user1, address(_NFTReceiver), 0);
        uint afterBalanceOf = _HW_Token.balanceOf(user1);
        assertEq(afterBalanceOf, 1);
        vm.stopPrank();
    }
}
