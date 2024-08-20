# Monero miner docker with pool or with p2pool protocol

[![Build Status][github-actions-img]][github-actions]
[![GPL-3 licensed][license-img]][license]
[![GitHub release][release-img]][release]
![GitHub downloads][downloads-img]

- Based on:
     - https://github.com/giansalex/monero-miner-docker
     - https://github.com/SChernykh/p2pool

## Pool mining vs Solo mining vs P2Pool mining

Here's the comparison table of the different ways of mining. While pool mining is the easiest to setup, it centralizes Monero network and pool admin gets full power over your hashrate and your unpaid funds. Solo mining is 100% independent and the best for the network. P2Pool mining has all the advantages of solo mining, but also makes regular payouts possible.

|Pool type|Payouts|Fee|Min. payout|Centralized?|Stability|Control|Setup
|-|-|-|-|-|-|-|-|
|Centralized pool|Regular|0-3%|0.001-0.01 XMR|Yes|Less stable due to pool server outages|Pool admin controls your mined funds, what you mine and can execute network attacks|Only miner software is required
|Solo|Rare|0%|0.6 XMR or more|No|As stable as your Monero node|100% under your control|Monero node + optional miner
|**P2Pool**|Regular|0%|~0.00027 XMR|No|Very stable: node failover and multiple Monero nodes are supported|100% under your control|Monero node(s) + P2Pool node(s) + optional miner(s)

### Pool status and monitoring pages 
- [https://p2pool.io/](https://p2pool.io/)
- [https://p2pool.io/mini/](https://p2pool.io/mini/)
- [https://p2pool.observer/](https://p2pool.observer/)
- [https://mini.p2pool.observer/](https://mini.p2pool.observer/)

## Monero mining with public pools

### How to run and stop with public pool
```bash
docker compose -f docker-compose-with-public-pool.yml  up --build

docker compose -f docker-compose-with-public-pool.yml  down
```

### Monero public pools
- [https://miningpoolstats.stream/monero](https://miningpoolstats.stream/monero)
- For testing, I use:
     - [https://xmr.nanopool.org/](https://xmr.nanopool.org/) - xmr-eu1.nanopool.org:10300
     - [https://supportxmr.com/](https://supportxmr.com/) - pool.supportxmr.com:3333

## Monero with p2pool protocol
- **IMPORTANT! You need between 70-90GB of free space and 7-10 hours to synchronise the entire monero blockchain.**

### How to run p2pool
```bash
docker compose up --build
```

### How to stop p2pool
```bash
docker compose down
```

### How to see p2pool statistics
- [http://localhost:3380/](http://localhost:3380/)

### Update containers
- All containers
```bash
docker compose build --no-cache
```

- For example Monero container
```bash
docker compose build --no-cache monero
```

### Pause and resume and disable and enable mining
```bash
docker compose pause xmrig 
docker compose unpause xmrig

docker compose stop xmrig 
docker compose start xmrig
```

### Uninstall
- Stop and remove all containers: 
```bash
docker compose down
```
- Remove the p2pool data:
```bash
docker volume rm p2pool
```
- Remove the p2pool-mini data: 
```bash
docker volume rm p2pool-mini
```
- Remove the monero data: 
```bash
docker volume rm monero
```

### xmrig references
- Alpine reference: [https://xmrig.com/docs/miner/build/alpine](https://xmrig.com/docs/miner/build/alpine)
- Ubuntu reference: [https://xmrig.com/docs/miner/build/ubuntu](https://xmrig.com/docs/miner/build/ubuntu)
- Doc: [https://xmrig.com/docs/miner](https://xmrig.com/docs/miner)

### Pending
- Add test when run p2pool to detect error: `Params Invalid wallet address. Try "p2pool --help".` to avoid incorrect or empty waller address