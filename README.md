# Gastimate

A method of computing gas cost in USD for foundry users. Convert estimated function gas usage to 'USD'.

## Usage

- Import Gastimate.sol
- Run startMeasuringGas("label") and stopMeasuringGas() before and after respective function calls to return gas cost in USD. The USD value is returned scaled by 1e2. A return value of 12 = $0.12, a return value of 4326 = $43.26. Currently gas estimates are off a bit compared to foundry's gas-report.
- Testing using mainnet fork. See [makefile](https://github.com/mattbrc/gastimate/blob/main/makefile) 'test-fork'

## To-Do

- Correct delta between price output compared to gas-report output

## Acknowledgements

- [foundry](https://github.com/foundry-rs/foundry)
- [solmate](https://github.com/Rari-Capital/solmate)
- [chainlink](https://github.com/smartcontractkit/chainlink)
