### 3.1.3 컴파일러 설치
mac - Solidity 설치
>brew update <br>
brew upgrade <br>
brew tap ethereum/ethereum <br>
brew install solidity <br>
brew linkapps solidity

Geth background rpc 실행
>nohup geth --networkid 4649 --nodiscover --maxpeers 0 --datadir /Users/jang/data_testnet --mine --minerthreads 1 --rpc --rpcaddr "0.0.0.0" --rpcport 8545 --rpccorsdomain "*" --rpcapi "admin,db,eth,debug,miner,net,ssh,txpool,personal,web3" --unlock 0,1 --password /Users/jang/data_testnet/passwd --verbosity 6 2>> /Users/jang/data_testnet/geth.log &

>geth attach rpc:http://localhost:8545
