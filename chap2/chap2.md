## 2. 이더리움이란?
- [공식사이트 - https://www.ethereum.org/](https://www.ethereum.org/)
> Ethereum is a decentralized platform that runs smart contracts <br> 이더리움이란 특별히 정해진 구현 방법을 말하는 것이 아니라 스마트 계약을 실행할 수 있는 플랫폼

### 2.2 Geth(Go-Ethereum) 설치
- 맥 OS에 설치 방법 - [참고](https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Mac)
- Homebrew를 이용한 설치([Homebrew 설치](https://brew.sh/index_ko))
- 터미널에서 아래의 명령어 실행
```
brew tab ethereum/ethereum
brew install ethereum
```

### 2.3 Geth 기동
- data_testnet 폴더 생성 후 genesis.json 파일 추가
```
{
	"config": {},
	"nonce": "0x0000000000000042",
	"timestamp": "0x0",
	"parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
	"gasLimit": "0x8000000",
	"difficulty": "0x4000",
	"mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
	"alloc": {}
}
```
- Geth 초기화(경로는 사용자에 맞게 변경)
```
geth --datadir /Users/jang/data_testnet init /Usersjang/data_testnet/genesis.json
```

- Geth 실행
```
geth --networkid 4649 --nodiscover --maxpeers 0 --datadir /Users/jang/data_testnet console 2>> /Users/jang/data_testnet/geth.log
```

### 2.4.1 계정 생성
- EOA 게정 생성
```
personal.newAccount("pass0")
```

- EOA 계정 확인(해당 이더리움의 노드가 관리하고 있는 계정 주소)
```
eth.accounts
eth.accounts[0]
eth.accounts[1]
```

- 송금 확인을 위한 추가 계정 생성
```
personal.newAccount("pass1")
personal.newAccount("pass2")
```

- geth 명령으로 계정 생성
```
geth --datadir /Users/jang/data_testnet account new
Address : {328b85c5e0b8f6d0b92b7b6e406bde9167fb6278}
```

- tree 명령으로 데이터 디렉터리 확인
```
tree data_testnet/
```

### 2.4.2 채굴
- Etherbase(이더리움에서 채굴에 성공했을 때 보상을 받는 계정 - 기본적으로 eth.account[0])
```
 eth.coinbase
```

- Etherbase 변경
```
miner.setEtherbase(eth.accounts[1])
```

- 잔고확인
```
eth.getBalance(eth.accounts[0])
```

- 블록체인의 블록 수 확인
```
eth.blockNumber
```

- 해시 속도 확인(hash/s)
```
eth.hashrate
```

- 채굴 시작
```
miner.start(1)
```

- DAG(Directed Ayclic Graph)
> CPU나 GPU의 병렬계산에 최적화 되어 있어서 메모리가 적게드는 비트코인과 다르게, 이더리움은 ASIC를 이용한 마이닝을 위해 메모리가 많이 사용되는 PoW(Proof of Work) 알고리즘인 DAG를 사용 <br>
채굴의 ASIC(Application Specific Integrated Circuit, 전용 IC칩) 내성을 위해 만들어지는 파일로 30,000블록(약 125시간마다 재생성)

- DAG 파일명 확인
```
tree .ethash/
```

- 채굴 중지
```
miner.stop()
```

- geth log 확인
```
tail -100f ~/data_testnet/geth.log
```

- wei -> ether 변환(1ether = 10^18wei)
```
web3.fromWei(eth.getBalance(eth.coinbase), "ether")
```

- ether -> wei
```
web3.toWei(number, "wei");
```

### 2.4.3 Ether 송금
- Etther 송금(실행결과는 발행한 트랜잭션 ID)
```
eth.sendTransaction({from:eth.accounts[0], to:eth.accounts[1], value:web3.toWei(10, "ether")})
```

- 계정 잠금 해제(잠금 해제 유효시간 기본 - 300초)
```
personal.unlockAccount(eth.accounts[0])
```

- 계정 잠금 해제(0 - Geth 프로세스 종료되기 전까지 해제)
```
personal.unlockAccount(eth.account[0], "pass0", 0)
```

- 송금 확인(sendTransaction으로 트랜잭션을 발행해도 처리안됨 -> 블록체인에서는 블록 안에 그 트랜잭션이 포함될 때 트랜잭션 내용이 실행)
```
eth.getBalance(eth.accounts[1])
```

- 트랜잭션 상태 확인(blockNumber가 null 상태로 블록에 포함되지 않았음)
``` eth.getTransaction("0xa85bfc2f487d8e2775795cae3dcf1f379feafe9e937378a1d9aba6b376a5e397")
{
  blockHash: "0x0000000000000000000000000000000000000000000000000000000000000000",
  blockNumber: null,
  from: "0xfa501cae369107a5010d1842b0ada628ab5b9f33",
  gas: 90000,
  gasPrice: 18000000000,
  hash: "0xa85bfc2f487d8e2775795cae3dcf1f379feafe9e937378a1d9aba6b376a5e397",
  input: "0x",
  nonce: 0,
  r: "0xd3d9411517b7e3be7c56b7c56e01dbb7f209620223c680d7c0e4dea308807f91",
  s: "0x6e1abeb08674e0e4b6daa18fa7904e62874cf8bc5e48c3c66fc093f02e4e56f5",
  to: "0xe3914bd95eb83a70b71255f80df8115fb9c41501",
  transactionIndex: 0,
  v: "0x1b",
  value: 10000000000000000000
}
```

- 계류(미처리 상태) 중인 트랜잭션 확인
```
eth.pendingTransactions
[{
    blockHash: null,
    blockNumber: null,
    from: "0xfa501cae369107a5010d1842b0ada628ab5b9f33",
    gas: 90000,
    gasPrice: 18000000000,
    hash: "0xa85bfc2f487d8e2775795cae3dcf1f379feafe9e937378a1d9aba6b376a5e397",
    input: "0x",
    nonce: 0,
    r: "0xd3d9411517b7e3be7c56b7c56e01dbb7f209620223c680d7c0e4dea308807f91",
    s: "0x6e1abeb08674e0e4b6daa18fa7904e62874cf8bc5e48c3c66fc093f02e4e56f5",
    to: "0xe3914bd95eb83a70b71255f80df8115fb9c41501",
    transactionIndex: 0,
    v: "0x1b",
    value: 10000000000000000000
}]
```

- 미처리된 트랜잭션 처리를 위해 채굴 실행(블록이 생성되면서 트랜잭션이 포함되고 트랜잭션의 내용이 실행되면서 송금 완료)
```
miner.start(1)
```

블록 확인(transactions 항목에 위의 트랜잭션 ID 표시)
```
eth.getBlock(173)
{
  difficulty: 142122,
  extraData: "0xd983010803846765746888676f312e31302e318664617277696e",
  gasLimit: 113345147,
  gasUsed: 21000,
  hash: "0xc6620118c3a3a2fb54b8b5d553b05ad1af902f361fe73a6aa9ce7645b28a4bd8",
  logsBloom: "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  miner: "0xfa501cae369107a5010d1842b0ada628ab5b9f33",
  mixHash: "0x0a4bcb0eb7a1bc96fabb500b8e129cb48aa8f11102aff05cd2563747ae88eef8",
  nonce: "0x374f7386542bfa6b",
  number: 173,
  parentHash: "0x0285bc2edc17585f9527e82b28a7c102adb1d01ab6e98244f7285dcd15b4f8ad",
  receiptsRoot: "0x9b0816cacd67150cef6db4e4858cf938d970452ed628ea7e7dfd4d69e7f15e1c",
  sha3Uncles: "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
  size: 653,
  stateRoot: "0x08afa3bd131b14f8a941721d45c59e5d5c38e7f60df1dbe3783bb3f5cadece6a",
  timestamp: 1523290167,
  totalDifficulty: 23640326,
  transactions: ["0xa85bfc2f487d8e2775795cae3dcf1f379feafe9e937378a1d9aba6b376a5e397"],
  transactionsRoot: "0x6419f8800de407a9646c861844c598d8f24331637a832a06f4c9d7e61c916cb6",
  uncles: []
}
```

### 2.4.4 트랜잭션 수수료
- 트랜잭션을 처리하기 위해서는 수수료(gas)가 필요
gas는 블록을 만들 때 주는 보상과 마찬가지로 채굴자(Etherbase)에게 지불됨

- 트랜잭션 정보 확인
  - gas : 90000 // 지불 가능한 최대 gas, 실제 해당 트랜잭션을 처리하는데 지불한 gas는 아님
  - gasPrice : 18000000000 //1Gas의 가격, 단위 wei/gas
```
eth.getTransaction("0xd3c1f71e5d20fcbc8e34a130c4b93bf6228aa1cd60377d4513668407be1fe9fd")
{
  blockHash: "0x3ce73c4b34bc7ed340f7e2c7be4923a81859f31c828ef15cca074d144022e8af",
  blockNumber: 1513,
  from: "0xe3914bd95eb83a70b71255f80df8115fb9c41501",
  gas: 90000,
  gasPrice: 18000000000,
  hash: "0xd3c1f71e5d20fcbc8e34a130c4b93bf6228aa1cd60377d4513668407be1fe9fd",
  input: "0x",
  nonce: 0,
  r: "0x378daa888e19d57db4385d2503f85da27325a99b73331ce2c5681a886edea36c",
  s: "0x268b055d39c94355ba38b8aac008090d4f768fa060214b46d24d4036ca81402b",
  to: "0x40d25c22152e50f2278b0e5ba2a609fee6e2b2d7",
  transactionIndex: 0,
  v: "0x1c",
  value: 10000000000000000000
}
```

- 지불한 수수료 계산 방법(wei / gasPrice)
  - 테스트에서 0.000347 ether가 지불되었으므로 계산하면 아래와 같음
```
web3.toWei(0.000347, 'ether') / 18000000000 = 19277.777777777777 gas
```

### 2.4.5 백그라운드로 Geth 기동
- Geth 백그라운드 실행 및 채굴
  - mine : 채굴 활성화
  - minerthreads 1  : 채굴에 사용할 CPU  a스레드 수
  - rpc : HTTP-RPC 서버 활성화
```
nohup geth --networkid 4649 --nodiscover --maxpeers 0 --datadir /Users/jang/data_testnet --mine --minerthreads 1 --rpc 2>> /Users/jang/data_testnet/geth.log &
```

### 2.4.6 JSON-RPC
- Geth 기동 시 HTTP-RPC 서버 활성화 해서 원격으로 명령 실행 하기위한 실행 방법 <br>
  - rpc : HTTP-RPC 서버 활성화
  - rpcaddr "0.0.0.0" : HTTP-RPC 서버의 수신 IP 설정
  - rpcport 8545  : HTTP-RPC 서버가 요청을 받기 위해 사용하는 포트 지정
  - rpccorsdomain "*" : 자신의 노드에 RPC로 접속할 IP 주소 지정, 쉼표로 구분해 여러 개를 지정 가능, "*"로 지정하면 모든 IP에서 접속 허용
  - rpcapi "admin,db..."  : RPC를 허가할 명령 지정
```
nohup geth --networkid 4649 --nodiscover --maxpeers 0 --datadir /Users/jang/data_testnet --mine --minerthreads 1 --rpc --rpcaddr "0.0.0.0" --rpcport 8545 --rpccorsdomain "*" --rpcapi "admin,db,eth,debug,miner,net,ssh,txpool,personal,web3" 2 >> /Users/jang/data_testnet/geth.log &
```

### 2.4.7 Geth 기동 시 계정 잠금 해제
- Geth 기동 시 지정한 계정을 잠금 해제
  - unlock 0  : 잠금 해제할 계정 지정
  - verbosity 6 : 로그 출력 수준 지정(default=3), 0=slient, 1=error, 2=warn, 3=info, 4=core, 5=debug, 6=detail
```
geth --networkid 4949 --nodiscover --maxpeers 0 --datadir /Users/jang/data_testnet --mine --minerthreads 1 --rpc --rpcaddr "0.0.0.0" --rpcport 8545 --rpccorsdomain "*" --rpcapi "admin,db,eth,debug,miner,net,ssh,txpool,personal,web3" --unlock 0 --verbosity 6 console 2>> /Users/jang/data_testnet/geth.log
```

- Geth 실행 시 파일에 저장한 계정 패스워드 불러와서 실행
```
geth --networkid 4949 --nodiscover --maxpeers 0 --datadir /Users/jang/data_testnet --mine --minerthreads 1 --rpc --rpcaddr "0.0.0.0" --rpcport 8545 --rpccorsdomain "*" --rpcapi "admin,db,eth,debug,miner,net,ssh,txpool,personal,web3" --unlock 0 --password /Users/jang/data_testnet/passwd --verbosity 6 console 2>> /Users/jang/data_testnet/geth.log
```
