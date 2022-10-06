// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Gastimate.sol";

contract GastimateTest is Test {
    Gastimate public gastimate;

    function setUp() public {
        gastimate = new Gastimate();
    }

    function testPriceFeed() public {
        int price = gastimate.getLatestPrice();
        emit log_named_int("price: ", price);
    }
}
