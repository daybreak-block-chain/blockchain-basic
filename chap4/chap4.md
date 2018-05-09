## 4.1

### 4.1.3 계약 실행
사용자 A - 0xfa501cae369107a5010d1842b0ada628ab5b9f33
사용자 B - 0xe3914bd95eb83a70b71255f80df8115fb9c41501
Create
  10000, "OreOreCoin", "oc", 0 //발행량, 이름, 단위, 소수점 이하 자릿수

OreOreCoin - accounts[0] 소유의 토큰
  block 2762
  0x4abe43525c1ab648a42c1e2e76685f711f8eadde

## 4.2 블랙리스트 기능 추카

OreOreCoin
  block 2948
  0x3873037b09caf37fd2e2fa783b244ba59a9db1ee


## 4.3 캐시백

OreOreCoin
  block 3066
  0xf13c2ef790da389916123701a26cbb5fae368aba


## 4.4 회원관리

Members
  block 3122
  0x79cfbc9667b28d24205ea3f6c6556dcb0fa2fdeb

회원 등급 생성(등급명, 최저거래횟수, 최저거래금액, 캐시백비율)
 - "Bronze",0,0,0
 - "Silver",5,500,5
 - "Gold",15,1500,10

OreOreCoin
 block 3163
 0xc1e42bd72c2db97a6096524f22eaf8d2409f6225



## 4.5 토큰 크라우드 세일
크라우드 세일(crowd sale) - 독자적인 토큰을 비트코인이나 이더리움 등의 가상 화폐를 지불 수단으로 해서 판매하는 자금 조달 수단

토큰(OreOreCoin)을 기간과 목표 금액 설정 후 크라우드 세일
기간 내 목표 금액을 달성하면 자금 제공자(Ether 입금)는 토큰을, 목표를 달성하지 못한 경우 Ether를 인출
크라우드 세일 판매자는 목표를 달성하면 Ether를 획득

### 4.5.3 계약 실행
크라우드 세일 달성 목표 - 10ether
1ether = 100oc, 최대 5000oc 발행
판매기간 15분

eth.accounts[0]: 0xfa501cae369107a5010d1842b0ada628ab5b9f33	 balance: 14344.00515159999999998ether
eth.accounts[1]: 0xe3914bd95eb83a70b71255f80df8115fb9c41501	 balance: 3004.9948484ether
eth.accounts[2]: 0x40d25c22152e50f2278b0e5ba2a609fee6e2b2d7	 balance: 10ether

생성할 토큰 정보(Create)
  10000, "OreOreCoin", "oc", 0

크라우드 세일 정보
  목표금액 : 10ether
  기한 : 15분
  토큰가격 : 1/100ether //1ether = 100oc
  전체토큰 : 5000oc
  얼리버드

OreOreCoin
  block 3571
  0xd2b0cc89abd8471a8ddfe235096741026e61b951

Crowdsale
  10, 5000, 100, "0xd2b0cc89abd8471a8ddfe235096741026e61b951"
  block 3584
  0x06d5b4d5dc92b8375b97cb0cad08d6e86a4ab1d6

크라우드 세일 주소에 5000 송금
  "0x06d5b4d5dc92b8375b97cb0cad08d6e86a4ab1d6", 5000
