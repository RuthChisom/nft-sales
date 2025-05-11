// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/NFTSales.sol";

contract FuzzNFTSalesTest is Test {
    function testFuzzRelease(uint96 fuzzAmount) public {
        address payer = address(1);
        address payee = address(2);

        vm.deal(payer, fuzzAmount);
        vm.prank(payer);
        NFTSales nftsales = new NFTSales{value: fuzzAmount}(payee);

        vm.prank(payer);
        nftsales.release();

        assertEq(payee.balance, fuzzAmount);
    }
}
