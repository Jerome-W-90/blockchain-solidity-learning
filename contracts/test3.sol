pragma solidity 0.8.8;

contract test3 {
    mapping(address => uint) Balances;

    function getBalance(address _myAddress) public view returns(uint) {
        return Balances[_myAddress];
    }

    receive() external payable {
        Balances[msg.sender] = msg.value;
    }
}