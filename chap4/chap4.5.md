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
  10000, "DayBreak", "db", 0

크라우드 세일 정보
  목표금액 : 10ether
  기한 : 15분
  토큰가격 : 1/100ether //1ether = 100oc
  전체토큰 : 5000oc
  조기구매특전
  - 개시에서 3분  미만 100% 추가지급
  - 개시에서 5분  미만  50% 추가지급
  - 개시에서 10분 미만  20% 추가지급
  - 10분 경과 후에는 추가 지급 없음 0%

DayBreak
  block 4966
  0x74ee4e87e74935de1378ae9302163e70f4ca8ab3

crowd sale(목표금액, 준비한 토큰의 양, 토큰가격(1ether당 토큰량 1:10), 토큰 주소)
  10, 5000, 100, "0x74ee4e87e74935de1378ae9302163e70f4ca8ab3"
  block 4076
  0x5986e0c6fd0dcbec5546b2be517bb72bf8530240

OreOreCoin > transfer, 크라우드 세일 주소에 5000 송금
  "0xa5de48f644db4a385c230aaa1b6356cf1ce48876", 5000



Gas limit 으로 console 에서 작업
cat crowd_sale_abi.txt | tr -d '\n' > crowd_sale_abi2.txt
