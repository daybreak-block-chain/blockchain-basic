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

### 3.2.1 콘솔에서 계약 만들기 - HelloWorld
사용자가 설정한 문자열을 반환하는 계약

```javascript
pragma solidity ^0.4.8;
contract HelloWorld {
  string public greeting;
  function HelloWorld(string _greeting) {
    greeting = _greeting;
  }
  function setGreeting(string _greeting) {
    greeting = _greeting;
  }
  function say() constant returns (string) {
    return greeting;
  }
}
```

현재 버전에서는 3.2.2 의 컴파일 명령어가 실행 안됨 -> Browser Solidity에서 계약 생성 및 테스트 후 진행

### 3.2.4 계약 배포
ABI(Application Binary Interface) : 계약의 외부 사양으로 계약에 포함되는 인수, 반환값에대한 정보로 계약에 접근할 때 필요한 정보 중 하나 <br>
Browser Solidiry에서 계약 생성 후 아래의 방법으로 확인 가능
1. Compile > 계약선택 > Detail 선택
![ABI 1](/chap3/img/Browser_Solidity_ABI_1.png) <br><br>
2. 팝업 창에서 ABI 확인
![ABI 2](/chap3/img/Browser_Solidity_ABI_2.png)

### 3.3 개발환경
Browser Solidity(Remix) : https://remix.ethereum.org
> Solidity 언어의 Contributor가 개발한 Solidity 언어 전용 웹 브라우저 기반 IDE

### 3.3.2 Browser-Solidity를 통해 이더리움 노드에 접속
1. 3.2.1에서 활용한 Geth background rpc 실행
>nohup geth --networkid 4649 --nodiscover --maxpeers 0 --datadir /Users/jang/data_testnet --mine --minerthreads 1 --rpc --rpcaddr "0.0.0.0" --rpcport 8545 --rpccorsdomain "*" --rpcapi "admin,db,eth,debug,miner,net,ssh,txpool,personal,web3" --unlock 0,1 --password /Users/jang/data_testnet/passwd --verbosity 6 2>> /Users/jang/data_testnet/geth.log &

2. 화면 우측 상단 Run > Environment 에서 Web3 Provier 선택
![RPC 접속](/chap3/img/Browser_Solidity_RUN_RPC_1.png) <br><br>
![RPC 접속](/chap3/img/Browser_Solidity_RUN_RPC_2.png)

3. 'Are you sure you want to connect to an ethereum node?' 에서 OK 선택
4. 'Web3 Provider Endpoint' 에서 http://localhost:8545 입력 후 OK 선택하면 접속 완료(접속이 실패 시 Geth가 실행 중인지 확인)
![RPC 접속](/chap3/img/Browser_Solidity_RUN_RPC_3.png)


### 3.3.3 Browser Solidity에서 계약 생성
1. Browser Solidity에서 좌측 상단 + 버튼을 눌러서 새로운 파일 생성
![HelloWorld](/chap3/img/Browser_Solidity_Hello_World_1.png)

2. 3.2.1의 HelloWorld 코드 입력

3. 배포(Create), 배포시 Geth에서 채굴이 진행되어야 함 - miner.start(1) <br>
계류(pendding) 상태에서 블록이 생성되면서 배포됨
![HelloWorld](/chap3/img/Browser_Solidity_Hello_World_2.png)

4. 하단 console 에서 Details를 선택해서 자세한 내용을 확인 가능
![HelloWorld](/chap3/img/Browser_Solidity_Hello_World_3.png)

5. 생성된 계약의 주소는 그림의 복사하기 버튼을을 누르면 복사됨
![HelloWorld](/chap3/img/Browser_Solidity_Hello_World_4.png)

### 3.3.4 기존 계약에 접근
1. 위에서 생성한 계약의 주소를 복사해서 At Adress 우측에 입력 후 버튼 클릭 <br>
접근된 계약의 정보가 하단에 표시
![HelloWorld](/chap3/img/Browser_Solidity_At_Address_1.png)

### 3.3.5 기존 계약에 접근2
Browser Solidity에서 배포한 계약을 콘솔로 접근
1. 기존 게약 접근에 필요한 ABI(3.2.4 에서 확인), 계약주소(3.3.3 에서 확인) 확인

2. 3.2.4에서 가져온 ABI 값의 줄 바꿈 제거 후 Geth 콘솔에서 abi 변수에 대입(작은 따옴표로 감싸준다)
> abi = '[{"constant": false,"inputs": [{"name": "_greeting","type": "string"}],"name": "setGreeting","outputs": [],"payable": false,"stateMutability": "nonpayable","type": "function"},{"inputs": [{"name": "_greeting","type": "string"}],"payable": false,"stateMutability": "nonpayable","type": "constructor"},{"constant": true,"inputs": [],"name": "greeting","outputs": [{"name": "","type": "string"}],"payable": false,"stateMutability": "view","type": "function"},{"constant": true,"inputs": [],"name": "say","outputs": [{"name": "","type": "string"}],"payable": false,"stateMutability": "view","type": "function"}]'

  ![Contract](/chap3/img/Browser_Solidity_Contract_1.png)

3. 계약 객체 생성
> contract = eth.contract(JSON.parse(abi)).at('0x7134212bfc8bc3e250cc0e2c4e9a84a7a83172da')

  ![Contract](/chap3/img/Browser_Solidity_Contract_2.png)

4. say 메소드 실행
> contract.say.call()

  ![Contract](/chap3/img/Browser_Solidity_Contract_3.png)
