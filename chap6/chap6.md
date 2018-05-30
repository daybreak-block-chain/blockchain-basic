### 6.3 예측 곤란성 확보하기
블록마다 값을 다르게 하기 위해 블록 해시 값을 사용 -> block.blockhash() 글로벌 함수 사용해서 가져옴
블록 해시 값은 블록별로 다르며 타임스탬프보다 사전 예측이 곤란한 값으로 처기 가능

1. 마지막 블록 번호 확인
>eth.blockNumber

2. 블록 정보 확인 - hash 값 확인
>eth.getBlock({blockNumber})

3. Remix에서 BlockHashTest.sol Deploy 후 getBlockHash에 블록 번호 입력해서 확인
Geth Console에서 확인한 hash 값과 동일함


#### '블록 해시 값을 사용한 난수 생성 에약' 스마트 계약 구현
1. RandomNumber1.sol, 6(난수 최대값) 입력 후 Deploy
2. request 버튼을 클릭해서 난수 생성 예약 실행
3. 결과 확인(블록넘버 확인) -> index는 0(예약번호) 반환
4. get 버튼 옆에 0 입력 후 실행
5. 결과 확인 -> status 0 - 난수 생성 성공 <br>
   drawnNumber 확인 <br>
   blockHash 값 확인 - request 때 생성된 블록넘버 + 1 의 블록 해시 값

### 6.3.3 고찰
get() 함수의 실행이 트랜잭션으로 처리 -> 응답성이 안좋음
블록 번호가 저장되어 있으면 언제든 난수 값 계산 가능(블록의 해시 값을 구할 수 있기 때문에)
1. RandomNumber2.sol, 6 입력 후 Deploy
2. get 버튼 초록색으로 표시 - constant 함수로 정의된 것
3. request 버튼을 클릭해서 난수 생성 예약
4. 결과 확인(블록넘버 확인) -> index는 0(예약번호) 반환
5. get 버튼 옆에 0 입력 후 실행
6. 결과 확인 -> status 0 - 난수 생성 성공 <br>
   drawnNumber 확인 <br>
   blockHash 값 확인 - request 때 생성된 블록넘버 + 1 의 블록 해시 값
