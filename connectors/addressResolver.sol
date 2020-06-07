pragma solidity ^0.5.9;

contract OracleAddrResolver {

    mapping(bytes32 => address) public oracleType;
    
    address owner;

    string[] public oracles;
    
    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function changeOwner(address newowner) onlyOwner public{
        owner = newowner;
    }
    
    function getAddress(string memory _oracleType) public returns (address oaddr){
        bytes32 __oracleType = sha256(abi.encodePacked(_oracleType));
        return oracleType[__oracleType];
    }
    
    function addOracleType(string memory oracleName, address oracleAddress) onlyOwner public {
        bytes32 __oracleType = sha256(abi.encodePacked(oracleName));
        require(oracleType[__oracleType] == address(0));
        oracles.push(oracleName);
        oracleType[__oracleType] = oracleAddress;
    }

    function removeOracleType(string memory oracleName) onlyOwner public {
        bytes32 __oracleType = sha256(abi.encodePacked(oracleName));
        require(oracleType[__oracleType] != address(0));
        delete oracleType[__oracleType];
        uint len = oracles.length;
        for(uint i = 0; i < len; i++){
            if(sha256(abi.encodePacked(oracles[i])) == __oracleType) {
                oracles[i] = oracles[oracles.length - 1];
                delete oracles[oracles.length - 1];
                oracles.length--;
                break;
            }
        }
    }

    function oracleArrayLen() public view returns (uint256 arrayLen) {
        return oracles.length;
    }
    
}
