// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "chainlink/interfaces/AggregatorV3Interface.sol";

contract Gastimate {
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
        // truncate decimals
        return price / 1e8;
    }

    function startMeasuringGas(string memory label) internal virtual {
        checkpointLabel = label;

        checkpointGasLeft = gasleft();
    }

    function stopMeasuringGas() internal virtual {
        uint256 checkpointGasLeft2 = gasleft();

        // Subtract 100 to account for the warm SLOAD in startMeasuringGas.
        uint256 gasDelta = checkpointGasLeft - checkpointGasLeft2 - 100;

        emit log_named_uint(
            string(abi.encodePacked(checkpointLabel, " Gas")),
            gasDelta
        );
    }
}
