constants = import_module("./src/package_io/constants.star")
dict = import_module("./src/package_io/dict.star")

# The deployment process is divided into various stages.
# You can deploy the whole stack and then only deploy a subset of the components to perform an
# an upgrade or to test a new version of a component.
DEFAULT_DEPLOYMENT_STAGES = {
    # Deploy a local L1 chain using the ethereum-package.
    # Set to false to use an external L1 like Sepolia.
    # Note that it will require a few additional parameters.
    "deploy_l1": False,
    # Deploy agglayer contracts on L1 (as well as fund accounts).
    # Set to false to use pre-deployed agglayer contracts.
    # Note that it will require a few additional parameters.
    "deploy_agglayer_contracts_on_l1": True,
    # Deploy databases.
    "deploy_databases": True,
    # Deploy CDK central/trusted environment.
    "deploy_cdk_central_environment": True,
    # Deploy CDK bridge infrastructure.
    "deploy_cdk_bridge_infra": True,
    # Deploy CDK bridge UI.
    "deploy_cdk_bridge_ui": False,
    # Deploy the agglayer.
    "deploy_agglayer": True,
    # Deploy cdk-erigon node.
    # TODO: Remove this parameter to incorporate cdk-erigon inside the central environment.
    "deploy_cdk_erigon_node": True,
    # Deploy Optimism rollup.
    # Note the default behavior will only deploy the OP Stack without CDK Erigon stack.
    # Setting to True will deploy the Aggkit components and Sovereign contracts as well.
    # Requires consensus_contract_type to be "pessimistic".
    "deploy_optimism_rollup": True,
    # After deploying OP Stack, upgrade it to OP Succinct.
    # Even mock-verifier deployments require an actual SPN network key.
    "deploy_op_succinct": False,
    # Deploy contracts on L2 (as well as fund accounts).
    "deploy_l2_contracts": False,
    # Deploy aggkit node in parallel to cdk node.
    "deploy_aggkit_node": False,
}

DEFAULT_IMAGES = {
    "aggkit_image": "ghcr.io/agglayer/aggkit:0.5.0-beta4",
    "aggkit_prover_image": "ghcr.io/agglayer/aggkit-prover:1.2.0",
    "agglayer_image": "ghcr.io/agglayer/agglayer:0.3.5",
    "agglayer_contracts_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/agglayer-contracts:v11.0.0-rc.2-fork.12",
    "anvil_image": "ghcr.io/foundry-rs/foundry:v1.0.0",
    "cdk_erigon_node_image": "hermeznetwork/cdk-erigon:v2.61.23",
    "cdk_sovereign_erigon_node_image": "hermeznetwork/cdk-erigon:v2.63.0-rc4",  # Type-1 CDK Erigon Sovereign
    "cdk_node_image": "ghcr.io/0xpolygon/cdk:0.5.4",
    "cdk_validium_node_image": "ghcr.io/0xpolygon/cdk-validium-node:0.6.4-cdk.10",
    "geth_image": "ethereum/client-go:v1.16.1",
    "lighthouse_image": "sigp/lighthouse:v7.1.0",
    "mitm_image": "mitmproxy/mitmproxy:11.1.3",
    "op_batcher_image": "us-docker.pkg.dev/oplabs-tools-artifacts/images/op-batcher:v1.14.0",
    "op_contract_deployer_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/op-deployer:v0.4.0-rc.2",
    "op_geth_image": "us-docker.pkg.dev/oplabs-tools-artifacts/images/op-geth:v1.101511.1",
    "op_node_image": "us-docker.pkg.dev/oplabs-tools-artifacts/images/op-node:v1.13.5",
    "op_proposer_image": "us-docker.pkg.dev/oplabs-tools-artifacts/images/op-proposer:v1.10.0",
    "op_succinct_proposer_image": "ghcr.io/agglayer/op-succinct/op-succinct:v2.3.3-agglayer",
    "status_checker_image": "ghcr.io/0xpolygon/status-checker:v0.2.8",
    "test_runner_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/e2e:9fe80e1",
    "zkevm_da_image": "ghcr.io/0xpolygon/cdk-data-availability:0.0.13",
    "zkevm_bridge_proxy_image": "haproxy:3.1-bookworm",
    "zkevm_bridge_service_image": "hermeznetwork/zkevm-bridge-service:v0.6.2-RC2",
    "zkevm_bridge_ui_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/zkevm-bridge-ui:0006445",
    "zkevm_node_image": "hermeznetwork/zkevm-node:v0.7.3",
    "zkevm_pool_manager_image": "hermeznetwork/zkevm-pool-manager:v0.1.2",
    "zkevm_prover_image": "hermeznetwork/zkevm-prover:v8.0.0-RC16-fork.12",
    "zkevm_sequence_sender_image": "hermeznetwork/zkevm-sequence-sender:v0.2.4",
}

DEFAULT_PORTS = {
    # agglayer-node
    "agglayer_grpc_port": 4443,
    "agglayer_readrpc_port": 4444,
    "agglayer_admin_port": 4446,
    "agglayer_metrics_port": 9092,
    # agglayer-prover
    "agglayer_prover_port": 4445,
    "agglayer_prover_metrics_port": 9093,
    # aggkit-prover
    "aggkit_prover_grpc_port": 4446,
    "aggkit_prover_metrics_port": 9093,
    "aggkit_pprof_port": 6060,
    "prometheus_port": 9091,
    "zkevm_aggregator_port": 50081,
    "zkevm_bridge_grpc_port": 9090,
    "zkevm_bridge_rpc_port": 8080,
    "zkevm_bridge_ui_port": 80,
    "zkevm_bridge_metrics_port": 8090,
    "zkevm_dac_port": 8484,
    "zkevm_data_streamer_port": 6900,
    "zkevm_executor_port": 50071,
    "zkevm_hash_db_port": 50061,
    "zkevm_pool_manager_port": 8545,
    "zkevm_pprof_port": 6060,
    "zkevm_rpc_http_port": 8123,
    "zkevm_rpc_ws_port": 8133,
    "cdk_node_rpc_port": 5576,
    "aggkit_node_rest_api_port": 5577,
    "blockscout_frontend_port": 3000,
    "anvil_port": 8545,
    "mitm_port": 8234,
    "op_succinct_proposer_metrics_port": 8080,
    "op_succinct_proposer_grpc_port": 50051,
    "op_proposer_port": 8560,
}

DEFAULT_STATIC_PORTS = {
    "static_ports": {
        ## L1 static ports (50000-50999).
        "l1_el_start_port": 50000,
        "l1_cl_start_port": 50010,
        "l1_vc_start_port": 50020,
        "l1_additional_services_start_port": 50100,
        ## L2 static ports (51000-51999).
        # Agglayer (51000-51099).
        "agglayer_start_port": 51000,
        "agglayer_prover_start_port": 51010,
        # CDK node (51100-51199).
        "cdk_node_start_port": 51100,
        # Bridge services (51200-51299).
        "zkevm_bridge_service_start_port": 51200,
        "zkevm_bridge_ui_start_port": 51210,
        "reverse_proxy_start_port": 51220,
        # Databases (51300-51399).
        "database_start_port": 51300,
        "pless_database_start_port": 51310,
        # Pool manager (51400-51499).
        "zkevm_pool_manager_start_port": 51400,
        # DAC (51500-51599).
        "zkevm_dac_start_port": 51500,
        # ZkEVM Provers (51600-51699).
        "zkevm_prover_start_port": 51600,
        "zkevm_executor_start_port": 51610,
        "zkevm_stateless_executor_start_port": 51620,
        # CDK erigon (51700-51799).
        "cdk_erigon_sequencer_start_port": 51700,
        "cdk_erigon_rpc_start_port": 51710,
        # L2 additional services (52000-52999).
        "arpeggio_start_port": 52000,
        "blutgang_start_port": 52010,
        "erpc_start_port": 52020,
        "panoptichain_start_port": 52030,
        "status_checker_start_port": 52040,
    }
}

# Addresses and private keys of the different components.
# They have been generated using the following command:
# polycli wallet inspect --mnemonic 'lab code glass agree maid neutral vessel horror deny frequent favorite soft gate galaxy proof vintage once figure diary virtual scissors marble shrug drop' --addresses 13 | tee keys.txt | jq -r '.Addresses[] | [.ETHAddress, .HexPrivateKey] | @tsv' | awk 'BEGIN{split("sequencer,aggregator,claimtxmanager,timelock,admin,loadtest,agglayer,dac,proofsigner,l1testing,aggoracle,sovereignadmin,claimsponsor",roles,",")} {print "# " roles[NR] "\n\"zkevm_l2_" roles[NR] "_address\": \"" $1 "\","; print "\"zkevm_l2_" roles[NR] "_private_key\": \"0x" $2 "\",\n"}'
DEFAULT_ACCOUNTS = {
    # sequencer
    "zkevm_l2_sequencer_address": "0xed301df1366fD2FAef70b6fA3D9c0E248a134CEF",
    "zkevm_l2_sequencer_private_key": "0xa5561c236a1167903d0af2ab343a84c96b9abaff0575a5588ef0fcd8ca351e87",
    # aggregator
    "zkevm_l2_aggregator_address": "0x8e086fEca8A29D72E20e4Ee4D989799900c5A141",
    "zkevm_l2_aggregator_private_key": "0x556afc514cc1e3d27e29607229a831438c4ea8996713071b090c8835124852f7",
    # claimtxmanager
    "zkevm_l2_claimtxmanager_address": "0x6d9e78f8848146bd613341C5b00eaC071cFf3E4D",
    "zkevm_l2_claimtxmanager_private_key": "0x08905d36be70abd0379e3cf07ded2ee9f98c4dd2504868f4f9e492fe5b42a780",
    # timelock
    "zkevm_l2_timelock_address": "0xbA6Fb89e83280209b0Eb4D1Aa3A597b3f25d39fc",
    "zkevm_l2_timelock_private_key": "0x4c228cf0a12c57a6dfa49f9a5055941f3429635f7c8b7b0da966290965930e05",
    # admin
    "zkevm_l2_admin_address": "0xb2689374ff0F6Dd8c005D009dF093Fdd4e0b974c",
    "zkevm_l2_admin_private_key": "0xcc1a62cd4f67fd2e43bf7d8bb67349c7fd95ddb8d489f23bea5442d9e3d107ee",
    # loadtest
    "zkevm_l2_loadtest_address": "0xcBE51FE6064a10057611247B87a1fF064bF6aac6",
    "zkevm_l2_loadtest_private_key": "0x4fa50114206ba5826aa6e308aa4074e728e399b2e29f02a2f4b9a351e1cb0e0c",
    # agglayer
    "zkevm_l2_agglayer_address": "0xF2cdcbBD2f96580d5A15e820586Fba160c44BA56",
    "zkevm_l2_agglayer_private_key": "0x284b9f8479b67aa1ee97fcb7632651bd6fba261ecf09c0498caf25c1188b448a",
    # dac
    "zkevm_l2_dac_address": "0x3C0DaE95d9f4f1564897bCc3C763de887AAa3ee3",
    "zkevm_l2_dac_private_key": "0xd48eaa16668be1d78d34d836fc44d07d2469673d48502833ff5e37ec4e9b0fd9",
    # proofsigner
    "zkevm_l2_proofsigner_address": "0x55738be67c20f37738d4AD854FfF78839cc693BA",
    "zkevm_l2_proofsigner_private_key": "0x8862ac4a159edeb7f90274f17038a3600b6208a0e4464f2cdaa54540962efa41",
    # l1testing
    "zkevm_l2_l1testing_address": "0x3b0e4651e723650981dfE02661bec074C8FC3CA6",
    "zkevm_l2_l1testing_private_key": "0x7620d3d720244cfc10e3c3e7ae7f283f93e67824edc698f2b1ffb753db8e0348",
    # aggoracle
    "zkevm_l2_aggoracle_address": "0x4B05eeB6edCA5D4a2615a1cabEc2Fc0902b1c5dd",
    "zkevm_l2_aggoracle_private_key": "0x2d3db0247f74d8bfbdc8c4d0eda92d8f69fc1e0865796ae2c5c6ffa006042101",
    # sovereignadmin
    "zkevm_l2_sovereignadmin_address": "0xf14311eB9bcFBa779F450ef96Ab77143A4639caB",
    "zkevm_l2_sovereignadmin_private_key": "0x9f97d7e6bb4d8084e596f6b8f554537a00b8b87a96709e30761dd69f8422b44a",
    # claimsponsor
    "zkevm_l2_claimsponsor_address": "0x5ac7cD7092B57356c5c3B9210412DBc5eb374b66",
    "zkevm_l2_claimsponsor_private_key": "0x2bea6a69f0d2c4f5b085e9596ab063eec77d4ba173c9ebea43ee66531a5b1e89",
}

DEFAULT_L1_ARGS = {
    # The L1 engine to use, either "geth" or "anvil".
    "l1_engine": "geth",
    # The L1 network identifier.
    "l1_chain_id": 11155111,
    # Custom L1 genesis
    "l1_custom_genesis": False,
    # This mnemonic will:
    # a) be used to create keystores for all the types of validators that we have, and
    # b) be used to generate a CL genesis.ssz that has the children validator keys already
    # preregistered as validators
    "l1_preallocated_mnemonic": "foil stage exotic equip exclude student paddle system client april ordinary trouble",
    # cast wallet private-key --mnemonic $l1_preallocated_mnemonic
    "l1_preallocated_private_key": "0x05627ddc3bcdfafc95cb97386003edf74711d67ddc0396288c3a344c25805e98",
    # The L1 HTTP RPC endpoint.
    "l1_rpc_url": "https://sepolia.infura.io/v3/25cd361b825548aea65604292ef6948f",
    # The L1 WS RPC endpoint.
    "l1_ws_url": "wss://sepolia.infura.io/ws/v3/25cd361b825548aea65604292ef6948f",
    # The L1 consensus layer RPC endpoint.
    "l1_beacon_url": "http://cl-1-lighthouse-geth:4000",
    # The additional services to spin up.
    # Default: []
    # Options:
    #   - assertoor
    #   - broadcaster
    #   - tx_spammer
    #   - bridge_spammer
    #   - blob_spammer
    #   - custom_flood
    #   - goomy_blob
    #   - el_forkmon
    #   - blockscout
    #   - beacon_metrics_gazer
    #   - dora
    #   - full_beaconchain_explorer
    #   - prometheus_grafana
    #   - blobscan
    #   - dugtrio
    #   - blutgang
    #   - forky
    #   - apache
    #   - tracoor
    # Check the ethereum-package for more details: https://github.com/ethpandaops/ethereum-package
    "l1_additional_services": [],
    # Preset for the network.
    # Default: "mainnet"
    # Options:
    #   - mainnet
    #   - minimal
    # "minimal" preset will spin up a network with minimal preset. This is useful for rapid testing and development.
    # 192 seconds to get to finalized epoch vs 1536 seconds with mainnet defaults
    # Please note that minimal preset requires alternative client images.
    "l1_preset": "minimal",
    # Number of seconds per slot on the Beacon chain
    # Default: 12
    "l1_seconds_per_slot": 2,
    # The amount of ETH sent to the admin, sequence, aggregator, sequencer and other chosen addresses.
    "l1_funding_amount": "1000000ether",
    # Default: 2
    "l1_participants_count": 1,
    # Whether to deploy https://github.com/AggLayer/lxly-bridge-and-call
    "l1_deploy_lxly_bridge_and_call": True,
    # Anvil: l1_anvil_slots_in_epoch will set the gap of blocks finalized vs safe vs latest
    #   l1_anvil_block_time * l1_anvil_slots_in_epoch -> total seconds to transition a block from latest to safe
    # l1_anvil_block_time: seconds per block
    "l1_anvil_block_time": 1,
    # l1_anvil_slots_in_epoch: number of slots in an epoch
    "l1_anvil_slots_in_epoch": 1,
    # Set this to true if the L1 contracts for the rollup are already
    # deployed. This also means that you'll need some way to run
    # recovery from outside of kurtosis
    # TODO at some point it would be nice if erigon could recover itself, but this is not going to be easy if there's a DAC
    "use_previously_deployed_contracts": False,
    "erigon_datadir_archive": None,
    "anvil_state_file": None,
    "mitm_proxied_components": {
        "agglayer": False,
        "aggkit": False,
        "bridge": False,
        "dac": False,
        "erigon-sequencer": False,
        "erigon-rpc": False,
        "cdk-node": False,
    },
}

DEFAULT_L2_ARGS = {
    # The number of accounts to fund on L2. The accounts will be derived from:
    # polycli wallet inspect --mnemonic '{{.l1_preallocated_mnemonic}}'
    "l2_accounts_to_fund": 10,
    # The amount of ETH sent to each of the prefunded l2 accounts.
    "l2_funding_amount": "100ether",
    # Whether to deploy https://github.com/Arachnid/deterministic-deployment-proxy.
    # Not deploying this will may cause errors or short circuit other contract
    # deployments.
    "l2_deploy_deterministic_deployment_proxy": True,
    # Whether to deploy https://github.com/AggLayer/lxly-bridge-and-call
    "l2_deploy_lxly_bridge_and_call": True,
    # This is used by erigon for naming the config files
    "chain_name": "kurtosis",
    # Config name for OP stack rollup
    "sovereign_chain_name": "op-sovereign",
    # TODO this seems like it comes from the op-succinct setup... we can probably get rid of this input
    # The minimum interval at which checkpoints must be submitted. No high security assumptions.
    "aggchain_submission_interval": 1,
}

DEFAULT_ROLLUP_ARGS = {
    # The keystore password.
    "zkevm_l2_keystore_password": "pSnv6Dh5s9ahuzGzH9RoCDrKAMddaX3m",
    # The rollup network identifier.
    "zkevm_rollup_chain_id": 2151908,
    # The unique identifier for the rollup within the RollupManager contract.
    # This setting sets the rollup as the first rollup.
    "zkevm_rollup_id": 1,
    # By default a mock verifier is deployed.
    # Change to true to deploy a real verifier which will require a real prover.
    # Note: This will require a lot of memory to run!
    "zkevm_use_real_verifier": False,
    # ForkID for the consensus contract. Must be 0 for AggchainFEP consensus.
    "fork_id": 12,
    # This flag will enable a stateless executor to verify the execution of the batches.
    # Set to true to run erigon as the sequencer.
    "erigon_strict_mode": True,
    # Set to true to use an L1 ERC20 contract as the gas token on the rollup.
    # The address of the gas token will be determined by the value of `gas_token_address`.
    "gas_token_enabled": True,
    # The address of the L1 ERC20 contract that will be used as the gas token on the rollup.
    # If the address is empty, a contract will be deployed automatically.
    "gas_token_address": "0xc197fb8a1EAa3cE845E14e52D419F5125f41814E",
    # The gas token origin network, to be used in BridgeL2SovereignChain.sol
    "gas_token_network": 0,
    # The sovereign WETH address, to be used in BridgeL2SovereignChain.sol
    "sovereign_weth_address": constants.ZERO_ADDRESS,
    # Flag to indicate if the wrapped ETH is not mintable, to be used in BridgeL2SovereignChain.sol
    "sovereign_weth_address_not_mintable": False,
    # Set to true to use Kurtosis dynamic ports (default) and set to false to use static ports.
    # You can either use the default static ports defined in this file or specify your custom static
    # ports.
    #
    # By default, Kurtosis binds the ports of enclave services to ephemeral or dynamic ports on the
    # host machine. To quote the Kurtosis documentation: "these ephemeral ports are called the
    # "public ports" of the container because they allow the container to be accessed outside the
    # Docker/Kubernetes cluster".
    # https://docs.kurtosis.com/advanced-concepts/public-and-private-ips-and-ports/
    "use_dynamic_ports": True,
    # Set this to true to disable all special logics in hermez and only enable bridge update in pre-block execution
    # https://hackmd.io/@4cbvqzFdRBSWMHNeI8Wbwg/r1hKHp_S0
    "enable_normalcy": False,
    # If the agglayer/aggkit-prover is going to use the network
    # prover, we'll need to provide an API Key Replace with a valid
    # SP1 key to use the SP1 Prover Network.
    "sp1_prover_key": "0xbcdf20249abf0ed6d944c0288fad489e33f66b3960d9e6229c1cd214ed3bbe31",
    # If we're setting an sp1 key, we might want to specify a specific RPC url as well
    "agglayer_prover_network_url": "https://rpc.production.succinct.xyz",
    # The type of primary prover to use in agglayer-prover. Note: if mock-prover is selected,
    # agglayer-node will also be configured with a mock verifier
    "agglayer_prover_primary_prover": "mock-prover",
    # The URL where the agglayer can be reached for gRPC
    "agglayer_grpc_url": "http://agglayer:"
    + str(DEFAULT_PORTS.get("agglayer_grpc_port")),
    # The URL where the agglayer can be reached for ReadRPC
    "agglayer_readrpc_url": "http://agglayer:"
    + str(DEFAULT_PORTS.get("agglayer_readrpc_port")),
    # The type of primary prover to use in aggkit-prover.
    "aggkit_prover_primary_prover": "mock-prover",
    # The URL where the aggkit-prover can be reached for gRPC
    "aggkit_prover_grpc_url_prefix": "aggkit-prover",
    # Enable aggkit pprof profiling
    "aggkit_pprof_enabled": True,
    # This is a path where the cdk-node will write data
    # https://github.com/0xPolygon/cdk/blob/d0e76a3d1361158aa24135f25d37ecc4af959755/config/default.go#L50
    "zkevm_path_rw_data": "/tmp",
    # OP Stack EL RPC URL. Will be dynamically updated by args_sanity_check() function.
    "op_el_rpc_url": "http://op-el-1-op-geth-op-node-001:8545",
    # OP Stack CL Node URL. Will be dynamically updated by args_sanity_check() function.
    "op_cl_rpc_url": "http://op-cl-1-op-node-op-geth-001:8547",
    # If the OP Succinct will use the Network Prover or CPU(Mock) Prover
    # true = mock
    # false = network
    "op_succinct_mock": False,
    "aggkit_components": "aggsender,aggoracle,bridge",
    # Toggle to enable the claimsponsor on the aggkit node.
    # Note: aggkit will only start the claimsponsor if the bridge is also enabled.
    "enable_aggkit_claim_sponsor": False,
}

DEFAULT_PLESS_ZKEVM_NODE_ARGS = {
    "trusted_sequencer_node_uri": "zkevm-node-sequencer-001:6900",
    "zkevm_aggregator_host": "zkevm-node-aggregator-001",
    "genesis_file": "templates/permissionless-node/genesis.json",
    "sovereign_genesis_file": "templates/sovereign-genesis.json",
}

DEFAULT_ADDITIONAL_SERVICES_PARAMS = {
    "blockscout_params": {
        "blockscout_public_port": DEFAULT_PORTS.get("blockscout_frontend_port"),
    },
}

DEFAULT_ARGS = (
    {
        # Suffix appended to service names.
        # Note: It should be a string.
        "deployment_suffix": "-001",
        # Verbosity of the `kurtosis run` output.
        # Valid values are "error", "warn", "info", "debug", and "trace".
        # By default, the verbosity is set to "info". It won't log the value of the args.
        "verbosity": "info",
        # The global log level that all components of the stack should log at.
        # Valid values are "error", "warn", "info", "debug", and "trace".
        "global_log_level": "info",
        "aggkit_prover_log_level": "info",
        # The type of the sequencer to deploy.
        # Options:
        # - 'erigon': Use the new sequencer (https://github.com/0xPolygonHermez/cdk-erigon).
        # - 'zkevm': Use the legacy sequencer (https://github.com/0xPolygonHermez/zkevm-node).
        "sequencer_type": "erigon",
        # The type of consensus contract to use.
        # Consensus Options:
        # - 'rollup': Transaction data is stored on-chain on L1.
        # - 'cdk_validium': Transaction data is stored off-chain using the CDK DA layer and a DAC.
        # - 'pessimistic': deploy with pessimistic consensus
        # Aggchain Consensus Options:
        # - 'ecdsa': Aggchain using an ECDSA signature with CONSENSUS_TYPE = 1.
        # - 'fep': Generic aggchain using Full Execution Proofs that relies on op-succinct stack.
        "consensus_contract_type": constants.CONSENSUS_TYPE.pessimistic,
        # Additional services to run alongside the network.
        # Options:
        # - arpeggio
        # - assertoor
        # - blockscout
        # - blutgang
        # - bridge_spammer
        # - erpc
        # - observability
        # - pless_zkevm_node
        # - rpc_fuzzer
        # - status_checker
        # - test_runner
        # - tx_spammer
        "additional_services": [
            constants.ADDITIONAL_SERVICES.test_runner,
            constants.ADDITIONAL_SERVICES.bridge_spammer,
        ],
        # Only relevant when deploying to an external L1.
        "polygon_zkevm_explorer": "https://explorer.private/",
        "l1_explorer_url": "https://sepolia.etherscan.io/",
    }
    | DEFAULT_IMAGES
    | DEFAULT_PORTS
    | DEFAULT_ACCOUNTS
    | DEFAULT_L1_ARGS
    | DEFAULT_ROLLUP_ARGS
    | DEFAULT_PLESS_ZKEVM_NODE_ARGS
    | DEFAULT_L2_ARGS
    | DEFAULT_ADDITIONAL_SERVICES_PARAMS
)

# https://github.com/ethpandaops/optimism-package
# The below OP params can be customized by specifically referring to an artifact or image.
# If none is is provided, it will refer to the default images from the Optimism-Package repo.
# https://github.com/ethpandaops/optimism-package/blob/main/src/package_io/input_parser.star
OP_ARTIFACTS_LOCATOR = "https://storage.googleapis.com/oplabs-contract-artifacts/artifacts-v1-02024c5a26c16fc1a5c716fff1c46b5bf7f23890d431bb554ddbad60971211d4.tar.gz"
DEFAULT_OP_STACK_ARGS = {
    "source": "github.com/agglayer/optimism-package/main.star@cc37713aff9c4955dd6975cdbc34072a1286754e",
    "predeployed_contracts": True,
    "chains": [
        {
            "participants": [
                {
                    "el_type": "op-geth",
                    "el_image": DEFAULT_IMAGES.get("op_geth_image"),
                    "el_extra_params": [
                        "--log.format=json",
                    ],
                    "cl_type": "op-node",
                    "cl_image": DEFAULT_IMAGES.get("op_node_image"),
                    "cl_extra_params": [
                        "--log.format=json",
                    ],
                    "count": 1,
                },
            ],
            "batcher_params": {
                "image": DEFAULT_ARGS.get("op_batcher_image"),
                "extra_params": [
                    "--log.format=json",
                ],
            },
            "proposer_params": {
                "image": DEFAULT_ARGS.get("op_proposer_image"),
                "extra_params": [
                    "--log.format=json",
                ],
            },
            "network_params": {
                # name maps to l2_services_suffix in optimism. The optimism-package appends a suffix with the following format: -<name>
                # the "-" however adds another "-" to the Kurtosis deployment_suffix. So we are doing string manipulation to remove the "-"
                "name": DEFAULT_ARGS.get("deployment_suffix")[1:],
                "network_id": str(DEFAULT_ROLLUP_ARGS.get("zkevm_rollup_chain_id")),
                # The blocktime on the OP network
                "seconds_per_slot": 1,
                # Isthmus fork
                # Defaults to None - not activated - decimal value
                # Offset is in seconds
                "isthmus_time_offset": 0,
            },
        },
    ],
    "op_contract_deployer_params": {
        "image": DEFAULT_ARGS.get("op_contract_deployer_image"),
        "l1_artifacts_locator": OP_ARTIFACTS_LOCATOR,
        "l2_artifacts_locator": OP_ARTIFACTS_LOCATOR,
    },
    "observability": {
        "enabled": False,
    },
}

VALID_ADDITIONAL_SERVICES = [
    getattr(constants.ADDITIONAL_SERVICES, field)
    for field in dir(constants.ADDITIONAL_SERVICES)
]

# A list of fork identifiers currently supported by Kurtosis CDK.
SUPPORTED_FORK_IDS = [9, 11, 12, 13]

VALID_CONSENSUS_TYPES = [
    constants.CONSENSUS_TYPE.rollup,
    constants.CONSENSUS_TYPE.cdk_validium,
    constants.CONSENSUS_TYPE.pessimistic,
    constants.CONSENSUS_TYPE.fep,
    constants.CONSENSUS_TYPE.ecdsa,
]


def parse_args(plan, user_args):
    # Merge the provided args with defaults.
    deployment_stages = DEFAULT_DEPLOYMENT_STAGES | user_args.get(
        "deployment_stages", {}
    )
    op_stack_args = user_args.get("optimism_package", {})
    args = DEFAULT_ARGS | user_args.get("args", {})

    # Change some params if anvil set to make it work
    # As it changes L1 config it needs to be run before other functions/checks
    set_anvil_args(plan, args, user_args)

    # Determine OP stack args.
    op_stack_args = get_op_stack_args(plan, args, op_stack_args)

    # Sanity check step for incompatible parameters
    args_sanity_check(plan, deployment_stages, args, user_args, op_stack_args)

    validate_consensus_type(args.get("consensus_contract_type"))

    # Setting mitm for each element set to true on mitm dict
    mitm_rpc_url = (
        "http://mitm"
        + args["deployment_suffix"]
        + ":"
        + str(DEFAULT_PORTS.get("mitm_port"))
    )
    args["mitm_rpc_url"] = {
        k: mitm_rpc_url for k, v in args.get("mitm_proxied_components", {}).items() if v
    }

    # Validation step.
    verbosity = args.get("verbosity", "")
    validate_log_level("verbosity", verbosity)

    global_log_level = args.get("global_log_level", "")
    validate_log_level("global log level", global_log_level)

    validate_additional_services(args.get("additional_services", []))

    # Determine fork id from the agglayer contracts image tag.
    agglayer_contracts_image = args.get("agglayer_contracts_image", "")
    (fork_id, fork_name) = get_fork_id(agglayer_contracts_image)

    # Determine sequencer and l2 rpc names.
    sequencer_type = args.get("sequencer_type", "")
    sequencer_name = get_sequencer_name(sequencer_type)

    deploy_cdk_erigon_node = deployment_stages.get("deploy_cdk_erigon_node", False)
    deploy_op_node = deployment_stages.get("deploy_optimism_rollup", False)
    l2_rpc_name = get_l2_rpc_name(deploy_cdk_erigon_node, deploy_op_node)

    # Determine static ports, if specified.
    if not args.get("use_dynamic_ports", True):
        plan.print("Using static ports.")
        args = DEFAULT_STATIC_PORTS | args

    # When using assertoor to test L1 scenarios, l1_preset should be mainnet for deposits and withdrawls to work.
    if "assertoor" in args["l1_additional_services"]:
        plan.print(
            "Assertoor is detected - changing l1_preset to mainnet and l1_participant_count to 2"
        )
        args["l1_preset"] = "mainnet"
        args["l1_participant_count"] = 2

    # Remove deployment stages from the args struct.
    # This prevents updating already deployed services when updating the deployment stages.
    if "deployment_stages" in args:
        args.pop("deployment_stages")

    args = args | {
        "l2_rpc_name": l2_rpc_name,
        "sequencer_name": sequencer_name,
        "zkevm_rollup_fork_id": fork_id,
        "zkevm_rollup_fork_name": fork_name,
        "deploy_agglayer": deployment_stages.get(
            "deploy_agglayer", False
        ),  # hacky but works fine for now.
    }

    # Sort dictionaries for debug purposes.
    sorted_deployment_stages = dict.sort_dict_by_values(deployment_stages)
    sorted_args = dict.sort_dict_by_values(args)
    sorted_op_stack_args = dict.sort_dict_by_values(op_stack_args)
    return (sorted_deployment_stages, sorted_args, sorted_op_stack_args)


def validate_log_level(name, log_level):
    if log_level not in (
        constants.LOG_LEVEL.error,
        constants.LOG_LEVEL.warn,
        constants.LOG_LEVEL.info,
        constants.LOG_LEVEL.debug,
        constants.LOG_LEVEL.trace,
    ):
        fail(
            "Unsupported {}: '{}', please use '{}', '{}', '{}', '{}' or '{}'".format(
                name,
                log_level,
                constants.LOG_LEVEL.error,
                constants.LOG_LEVEL.warn,
                constants.LOG_LEVEL.info,
                constants.LOG_LEVEL.debug,
                constants.LOG_LEVEL.trace,
            )
        )


def validate_additional_services(additional_services):
    for svc in additional_services:
        if svc not in VALID_ADDITIONAL_SERVICES:
            fail(
                "Unsupported additional service: '{}', please use one of: '{}'".format(
                    svc, VALID_ADDITIONAL_SERVICES
                )
            )


def get_fork_id(agglayer_contracts_image):
    """
    Extract the fork identifier and fork name from a agglayer contracts image name.

    The agglayer contracts tags follow the convention:
    v<SEMVER>-rc.<RC_NUMBER>-fork.<FORK_ID>[-patch.<PATCH_NUMBER>]

    Where:
    - <SEMVER> is the semantic versioning (MAJOR.MINOR.PATCH).
    - <RC_NUMBER> is the release candidate number.
    - <FORK_ID> is the fork identifier.
    - -patch.<PATCH_NUMBER> is optional and represents the patch number.

    Example:
    - v8.0.0-rc.2-fork.12
    - v7.0.0-rc.1-fork.10
    - v7.0.0-rc.1-fork.11-patch.1
    """
    result = agglayer_contracts_image.split("-patch.")[0].split("-fork.")
    if len(result) != 2:
        fail(
            "The agglayer contracts image tag '{}' does not follow the standard v<SEMVER>-rc.<RC_NUMBER>-fork.<FORK_ID>".format(
                agglayer_contracts_image
            )
        )

    fork_id = int(result[1])
    if fork_id not in SUPPORTED_FORK_IDS:
        fail("The fork id '{}' is not supported by Kurtosis CDK".format(fork_id))

    fork_name = "elderberry"
    if fork_id >= 12:
        fork_name = "banana"
    # TODO: Add support for durian once released.

    return (fork_id, fork_name)


def get_sequencer_name(sequencer_type):
    if sequencer_type == constants.SEQUENCER_TYPE.CDK_ERIGON:
        return "cdk-erigon-sequencer"
    elif sequencer_type == constants.SEQUENCER_TYPE.ZKEVM:
        return "zkevm-node-sequencer"
    else:
        fail(
            "Unsupported sequencer type: '{}', please use '{}' or '{}'".format(
                sequencer_type,
                constants.SEQUENCER_TYPE.CDK_ERIGON,
                constants.SEQUENCER_TYPE.ZKEVM,
            )
        )


def get_l2_rpc_name(deploy_cdk_erigon_node, deploy_op_node):
    if deploy_op_node:
        return "op-el-1-op-geth-op-node"
    if deploy_cdk_erigon_node:
        return "cdk-erigon-rpc"
    return "zkevm-node-rpc"


def get_op_stack_args(plan, args, user_op_stack_args):
    op_stack_args = DEFAULT_OP_STACK_ARGS | user_op_stack_args

    l1_chain_id = str(args.get("l1_chain_id", ""))
    l1_rpc_url = args.get("l1_rpc_url", "")
    l1_ws_url = args.get("l1_ws_url", "")
    l1_beacon_url = args.get("l1_beacon_url", "")

    l1_preallocated_mnemonic = args.get("l1_preallocated_mnemonic", "")
    private_key_result = plan.run_sh(
        description="Deriving the private key from the mnemonic",
        run="cast wallet private-key --mnemonic \"{}\" | tr -d '\n'".format(
            l1_preallocated_mnemonic
        ),
        image=constants.TOOLBOX_IMAGE,
    )
    private_key = private_key_result.output

    source = op_stack_args.pop("source")
    predeployed_contracts = op_stack_args.pop("predeployed_contracts")

    return {
        "source": source,
        "predeployed_contracts": predeployed_contracts,
        "optimism_package": op_stack_args,
        "external_l1_network_params": {
            "network_id": l1_chain_id,
            "rpc_kind": "standard",
            "el_rpc_url": l1_rpc_url,
            "el_ws_url": l1_ws_url,
            "cl_rpc_url": l1_beacon_url,
            "priv_key": private_key,
        },
    }


def set_anvil_args(plan, args, user_args):
    if args["anvil_state_file"] != None:
        if user_args.get("args", {}).get("l1_engine") != "anvil":
            args["l1_engine"] = "anvil"
            plan.print("Anvil state file detected - changing l1_engine to anvil")

    if args["l1_engine"] == "anvil":
        # We override only is user did not provide explicit values
        if not user_args.get("args", {}).get("l1_rpc_url"):
            args["l1_rpc_url"] = (
                "http://anvil"
                + args["deployment_suffix"]
                + ":"
                + str(DEFAULT_PORTS.get("anvil_port"))
            )
        if not user_args.get("args", {}).get("l1_ws_url"):
            args["l1_ws_url"] = (
                "ws://anvil"
                + args["deployment_suffix"]
                + ":"
                + str(DEFAULT_PORTS.get("anvil_port"))
            )
        if not user_args.get("args", {}).get("l1_beacon_url"):
            args["l1_beacon_url"] = (
                "http://anvil"
                + args["deployment_suffix"]
                + ":"
                + str(DEFAULT_PORTS.get("anvil_port"))
            )


# Helper function to compact together checks for incompatible parameters in input_parser.star
def args_sanity_check(plan, deployment_stages, args, user_args, op_stack_args):
    # Fix the op stack el rpc urls according to the deployment_suffix.
    if args["op_el_rpc_url"] != "http://op-el-1-op-geth-op-node" + args[
        "deployment_suffix"
    ] + ":8545" and deployment_stages.get("deploy_op_stack", False):
        plan.print(
            "op_el_rpc_url is set to '{}', changing to 'http://op-el-1-op-geth-op-node{}:8545'".format(
                args["op_el_rpc_url"], args["deployment_suffix"]
            )
        )
        args["op_el_rpc_url"] = (
            "http://op-el-1-op-geth-op-node" + args["deployment_suffix"] + ":8545"
        )
    # Fix the op stack cl rpc urls according to the deployment_suffix.
    if args["op_cl_rpc_url"] != "http://op-cl-1-op-node-op-geth" + args[
        "deployment_suffix"
    ] + ":8547" and deployment_stages.get("deploy_op_stack", False):
        plan.print(
            "op_cl_rpc_url is set to '{}', changing to 'http://op-cl-1-op-node-op-geth{}:8547'".format(
                args["op_cl_rpc_url"], args["deployment_suffix"]
            )
        )
        args["op_cl_rpc_url"] = (
            "http://op-cl-1-op-node-op-geth" + args["deployment_suffix"] + ":8547"
        )
    # The optimism-package network_params is a frozen hash table, and is not modifiable during runtime.
    # The check will return fail() instead of dynamically changing the network_params name.
    if op_stack_args["optimism_package"]["chains"][0]["network_params"]["name"] != args[
        "deployment_suffix"
    ][1:] and deployment_stages.get("deploy_op_stack", False):
        fail(
            "op_stack_args network_params name is set to '{}', please change it to match deployment_suffix '{}'".format(
                op_stack_args["optimism_package"]["chains"][0]["network_params"][
                    "name"
                ],
                args["deployment_suffix"][1:],
            )
        )

    # Check args[zkevm_rollup_chain_id] and op_stack_args["optimism_package"]["chains"][0]["network_params"]["network_id"] are equal.
    if str(args["zkevm_rollup_chain_id"]) != str(
        op_stack_args["optimism_package"]["chains"][0]["network_params"]["network_id"]
    ) and deployment_stages.get("deploy_op_stack", False):
        fail(
            "op_stack_args network_params network_id is set to '{}', please change it to match zkevm_rollup_chain_id '{}'".format(
                op_stack_args["optimism_package"]["chains"][0]["network_params"][
                    "network_id"
                ],
                args["zkevm_rollup_chain_id"],
            )
        )

    # Unsupported L1 engine check
    if args["l1_engine"] not in constants.L1_ENGINES:
        fail(
            "Unsupported L1 engine: '{}', please use one of {}".format(
                args["l1_engine"], constants.L1_ENGINES
            )
        )

    # CDK Erigon normalcy and strict mode check
    if args["enable_normalcy"] and args["erigon_strict_mode"]:
        fail("normalcy and strict mode cannot be enabled together")

    # OP rollup deploy_optimistic_rollup and consensus_contract_type check
    if deployment_stages.get("deploy_optimism_rollup", False):
        if args["consensus_contract_type"] != constants.CONSENSUS_TYPE.pessimistic:
            if (
                args["consensus_contract_type"] != "fep"
                and args["consensus_contract_type"] != "ecdsa"
            ):
                plan.print(
                    "Current consensus_contract_type is '{}', changing to pessimistic for OP deployments.".format(
                        args["consensus_contract_type"]
                    )
                )
                # TODO: should this be AggchainFEP instead?
                args["consensus_contract_type"] = constants.CONSENSUS_TYPE.pessimistic

    # If OP-Succinct is enabled, OP-Rollup must be enabled
    if deployment_stages.get("deploy_op_succinct", False):
        if deployment_stages.get("deploy_optimism_rollup", False) == False:
            fail(
                "OP Succinct requires OP Rollup to be enabled. Change the deploy_optimism_rollup parameter"
            )
        if args["sp1_prover_key"] == None or args["sp1_prover_key"] == "":
            fail("OP Succinct requires a valid SPN key. Change the sp1_prover_key")

    # OP rollup check L1 blocktime >= L2 blocktime
    op_network_params = op_stack_args["optimism_package"]["chains"][0]["network_params"]
    if deployment_stages.get("deploy_optimism_rollup", False):
        if args.get("l1_seconds_per_slot", 12) < op_network_params.get(
            "seconds_per_slot", 1
        ):
            fail(
                "OP Stack rollup requires L1 blocktime > 1 second. Change the l1_seconds_per_slot parameter"
            )

    # FIXME - I've removed some code here that was doing some logic to
    # update the vkeys depending on the consensus. We either need to
    # have different vkeys depending on the context (e.g. if we're
    # deploying the rollpu manager it needs to be set
    # (VKeyCannotBeZero() 0x6745305e), but if we're creating an
    # aggchainFEP it must not be set) or we can hard code to be
    # 0x000...000 in the situations where we know it must be zero


def validate_consensus_type(consensus_type):
    if consensus_type not in VALID_CONSENSUS_TYPES:
        fail(
            'Invalid consensus type: "{}". Allowed value(s): {}.'.format(
                consensus_type, VALID_CONSENSUS_TYPES
            )
        )
