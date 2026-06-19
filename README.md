# SomboPaymaster — ERC-4337 Sponsoring Paymaster

Oracle School Workshop-06 · No.88 Sombo · Chain ID `20260619`

## Live Services

| Service | URL |
|---------|-----|
| 🖥️ Frontend | http://141.11.156.4:8088 |
| 🔍 OtterScan | http://141.11.156.4:5100 |
| ⛓️ Anvil RPC | http://141.11.156.4:8588 |

## Quick Sync

```bash
# Verify chain
cast chain-id --rpc-url http://141.11.156.4:8588
# → 20260619

# Get latest block
cast block-number --rpc-url http://141.11.156.4:8588
```

## Run Locally

```bash
anvil --chain-id 20260619 --host 0.0.0.0 --port 8588 --block-time 2
```

## Structure

```
src/SomboPaymaster.sol    ERC-4337 Sponsoring Paymaster
script/Deploy.s.sol       Deploy to Sepolia / local Anvil
frontend/index.html       Chain status dashboard (port 8088)
genesis.json              Chain genesis (chainId 20260619)
docker-compose.yml        anvil + nginx via Docker
```

## Contract

- **Type**: Sponsoring Paymaster (covers gas for all users)
- **EntryPoint**: `0x0000000071727De22E5E9d8BAf0edAc6f37da032` (v0.7)
- **Target**: Sepolia (11155111) — local dev on Anvil (20260619)
