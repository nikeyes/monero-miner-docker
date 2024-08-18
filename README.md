# monero-miner-docker
Based on https://github.com/giansalex/monero-miner-docker

## Monero Pools
- [https://miningpoolstats.stream/monero](https://miningpoolstats.stream/monero)
- For testing, I use:
     - [https://xmr.nanopool.org/](https://xmr.nanopool.org/) - xmr-eu1.nanopool.org:10300
     - [https://supportxmr.com/](https://supportxmr.com/) - pool.supportxmr.com:3333

## How to build
```bash
docker build -t monero-miner .
```

## How to run
```bash
docker run monero-miner
```

## xmrig 
- Alpine reference: [https://xmrig.com/docs/miner/build/alpine](https://xmrig.com/docs/miner/build/alpine)
- Doc: [https://xmrig.com/docs/miner](https://xmrig.com/docs/miner)
