-include .env

# DEPLOY OAPP CONTRACTS

deploy-to-base:
	forge create ./src/ABA.sol:ABA --rpc-url $(BASE_SEPOLIA_RPC) --constructor-args $(BASE_SEPOLIA_LZ_ENDPOINT) $(DEPLOYER_PUBLIC_ADDRESS) --etherscan-api-key $(BASE_ETHERSCAN_API_KEY) --verify --account deployer

deploy-to-optimism:
	forge create ./src/ABA.sol:ABA --rpc-url $(OPTIMISM_SEPOLIA_RPC) --constructor-args $(OPTIMISM_SEPOLIA_LZ_ENDPOINT) $(DEPLOYER_PUBLIC_ADDRESS) --etherscan-api-key $(OPTIMISM_ETHERSCAN_API_KEY) --verify --account deployer

# SET PEERS / WIRE UP

set-base-peer:
	cast send $(BASE_SEPOLIA_OAPP_ADDRESS) --rpc-url $(BASE_SEPOLIA_RPC) "setPeer(uint32, bytes32)" $(OPTIMISM_SEPOLIA_LZ_ENDPOINT_ID) $(OPTIMISM_SEPOLIA_OAPP_BYTES32) --account deployer

set-optimism-peer:
	cast send $(OPTIMISM_SEPOLIA_OAPP_ADDRESS) --rpc-url $(OPTIMISM_SEPOLIA_RPC) "setPeer(uint32, bytes32)" $(BASE_SEPOLIA_LZ_ENDPOINT_ID) $(BASE_SEPOLIA_OAPP_BYTES32) --account deployer

# send-a-b-only:
# 	cast send $(BASE_SEPOLIA_OAPP_ADDRESS) --rpc-url $(BASE_SEPOLIA_RPC) "send(uint32,uint16,string,bytes,bytes)" $(OPTIMISM_SEPOLIA_LZ_ENDPOINT_ID) 1 "ABO Worked!" $(ABA_MESSAGE_OPTIONS_BYTES) $(ABO_MESSAGE_OPTIONS_BYTES) --value 0.1ether --account deployer

# send options need to have the msg.value for the receiving end, then the options on that end can just have no msg.value because it just returns it to the original OApp
send-a-b-a:
	cast send $(BASE_SEPOLIA_OAPP_ADDRESS) --rpc-url $(BASE_SEPOLIA_RPC) "send(uint32,uint16,string,bytes,bytes)" $(OPTIMISM_SEPOLIA_LZ_ENDPOINT_ID) 2 "hELLO FROM BASE!" $(ABA_MESSAGE_OPTIONS_BYTES) $(ABO_MESSAGE_OPTIONS_BYTES) --value 0.2ether --account deployer

