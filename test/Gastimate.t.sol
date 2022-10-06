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
        gastimate.startMeasuringGas("price feed");
        int price = gastimate.getLatestPrice();
        gastimate.stopMeasuringGas();
    }

    function testMaths() public {
        gastimate.startMeasuringGas("math test");
        gastimate.doStuff(1233);
        gastimate.stopMeasuringGas();
        console.log("tx.gasprice", tx.gasprice);
    }
}
