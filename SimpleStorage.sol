pragma solidity ^0.4.20;

contract SimpleStorage {
    uint storedNum; // cannot be negative

    function set(uint x) public {
        storedNum = x;
    }

    // "view" modifier means this function does 
    // not modify the state of the contract.
    // Function can be executed locally, no need to 
    // propose a transaction to the blockchain
    function get() public view returns (uint) {
        return storedNum;
    }
}
