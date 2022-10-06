// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "chainlink/interfaces/AggregatorV3Interface.sol";
import "forge-std/Test.sol";

contract Gastimate is Test {
    AggregatorV3Interface internal priceFeed;
    string private checkpointLabel;
    uint256 private checkpointGasLeft = 1; // Start the slot warm.

    /**
     * Network: Mainnet
     * Aggregator: ETH/USD
     * Address: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
     */
    constructor() {
        priceFeed = AggregatorV3Interface(
            0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        );
    }

    function getLatestPrice() public view returns (int) {
        (, int price, , , ) = priceFeed.latestRoundData();
        // for ETH / USD price is scaled up by 10 ** 8
        return price / 1e8;
    }

    // from solmate/test/utils/DSTestPlus.sol
    function startMeasuringGas(string memory label) public {
        checkpointLabel = label;

        checkpointGasLeft = gasleft();
    }

    // from solmate/test/utils/DSTestPlus.sol
    function stopMeasuringGas() public {
        uint256 checkpointGasLeft2 = gasleft();

        // Subtract 100 to account for the warm SLOAD in startMeasuringGas.
        uint256 gasDelta = checkpointGasLeft - checkpointGasLeft2 - 100;
        uint256 price = tx.gasprice;
        // scale return value to 100*USD
        // ex. return value of 05 = $0.05
        uint256 gasUSD = ((gasDelta * price) * uint(getLatestPrice())) / 1e16;

        emit log_named_uint(
            string(abi.encodePacked(checkpointLabel, " Gas Price USD")),
            gasUSD
        );
    }

    function doStuff(uint256 number) public returns (uint256) {
        uint256 num = number;
        uint256 maths = num * 15e18;
        return (maths);
    }
}
