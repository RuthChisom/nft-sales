// Unit tests
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/NFTSales.sol";
import "../src/Receiver.sol";

contract NFTSalesTest is Test {
    NFTSales nftsales;
    Receiver receiver;
    address payer;
    address payee;

    function setUp() public {
        payer = makeAddr("payer");
        payee = makeAddr("payee");
        vm.deal(payer, 10 ether);
        vm.prank(payer);
        nftsales = new NFTSales{value: 5 ether}(payee);
    }

    function testInitialBalance() view public {
        assertEq(nftsales.getBalance(), 5 ether);
    }

    function testOnlyPayerCanRelease() public {
        vm.prank(payee);
        vm.expectRevert("Only payer can release");
        nftsales.release();
    }

    function testReleaseFunds() public {
        uint before = payee.balance;
        vm.prank(payer);
        nftsales.release();
        assertEq(payee.balance, before + 5 ether);
    }
}
