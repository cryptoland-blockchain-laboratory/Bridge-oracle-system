pragma solidity ^0.5.8;


contract Oracle {
    
    event Log1(address sender, uint timestamp, string _datasource, string _arg, uint gaslimit);
    
    
    mapping (address => uint) internal reqc;
	
	function query(string calldata _datasource, string calldata _arg) external payable returns(bytes32 _id) {
		//set gasLimit tron blockchain
	 	return query1(0, _datasource, _arg, 200000);
    }

    function query_withGasLimit(uint _timestamp, string memory _datasource, string memory _arg, uint _gaslimit) external payable returns(bytes32 _id) {
    	return query1(_timestamp, _datasource, _arg, _gaslimit);
    }


    function query1(uint _timestamp, string memory _datasource, string memory _arg, uint _gaslimit) public payable returns(bytes32 _id) {
    	reqc[msg.sender]++;
	  	bytes32 customHash = keccak256('keyvan');
	  	emit Log1(msg.sender, _timestamp, _datasource, _arg, _gaslimit);
	  	return customHash;
    }
}