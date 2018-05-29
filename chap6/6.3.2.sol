pragma solidity ^0.4.8;

contract RandomNumber {
    address owner;
    uint numberMax;

    struct draw {
        uint blockNumber;
        uint drawnNumber;
    }

    struct draws {
        uint numDraws;
        mapping (uint => draw) draws;
    }

    mapping (address => draws) requests;

    event ReturnNextIndex(uint _index);
    event ReturnDraw(int _status, bytes32 _blockhash, uint _drawnNumber);

    function RandomNumber(uint _max) {
        owner = msg.sender;
        numberMax = _max;
    }

    function request() returns (uint) {
        uint _nextIndex = requests[msg.sender].numDraws;
        requests[msg.sender].draws[_nextIndex].blockNumber = block.number;
        requests[msg.sender].numDraws = _nextIndex + 1;
        ReturnNextIndex(_nextIndex);
        return _nextIndex;
    }

    function get(uint _index) returns (int status, bytes32 blockhash, uint drawnNumber){
        if(_index >= requests[msg.sender].numDraws){
            ReturnDraw(-2, 0, 0);
            return (-2, 0, 0);
        }else{
            uint _nextBlockNumber = requests[msg.sender].draws[_index]. blockNumber + 1;
            if (_nextBlockNumber >= block.number) {
                ReturnDraw(-1, 0, 0);
                return (-1, 0, 0);
            }else{
                bytes32 _blockhash = block.blockhash(_nextBlockNumber);
                uint _drawnNumber = uint(_blockhash) % numberMax + 1;
                requests[msg.sender].draws[_index].drawnNumber = _drawnNumber;
                ReturnDraw(0, _blockhash, _drawnNumber);
                return (0, _blockhash, _drawnNumber);
            }
        }
    }
}
