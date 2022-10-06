# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build
test  :; forge test
trace  :; forge test -vvv
# tests with forks
test-fork :; forge test --fork-url $(MAINNET_URL) --match-contract Gastimate -vvv
# fork mainnnet
anvil :; anvil --fork-url $(MAINNET_URL)
clean  :; forge clean
snapshot :; forge snapshot
