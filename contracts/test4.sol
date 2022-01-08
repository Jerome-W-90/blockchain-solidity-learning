pragma solidity 0.8.8;

contract test4 {
    struct balance {
        uint money;
        uint numPayment;
    }

    mapping(address => balance) Balances;

    function getBalance() public view returns(uint) {
        return Balances[msg.sender].money;
    }

    function getNumPayment() public view returns (uint) {
        return Balances[msg.sender].numPayment;
    }

    receive() external payable {
        Balances[msg.sender].money += msg .value;
        Balances[msg.sender].numPayment += 1;
    }
}