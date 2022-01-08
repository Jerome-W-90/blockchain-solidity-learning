pragma solidity 0.8.8;

contract testString {
    string mySentence;

    function getSentence() public view returns(string memory) {
        return mySentence;
    }

    function setSentence(string memory _mySentence) public {
        mySentence = _mySentence;
    }
}