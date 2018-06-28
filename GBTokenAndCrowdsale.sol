pragma solidity ^0.4.20;

/* Simple implementation of a crowd sale. You send Ether, this contract sends you tokens.
*/
contract GBTokenAndCrowdsale {

    /* This creates an array with all balances */
    mapping (address => uint) balances;
    
    /* Owner of the token funds -- the one who creates the contract */
    address tokenFundsAddress;

    /* Price of a GBT token, in 'wei' denomination */
    uint constant private TOKEN_PRICE_IN_WEI = 1 * 1 ether;

    /* This generates a public event on the blockchain that will notify listening clients */
    event TransferGB(address indexed from, address indexed to, uint value);
    event FundsRaised(address indexed from, uint fundsReceivedInWei, uint tokensIssued);

    /* Initialize the contract, this is the "constructor" */
    constructor(uint initialSupply) public {
        // give all tokens to the creator of the contract
        balances[msg.sender] = initialSupply;
        tokenFundsAddress = msg.sender;
    }
    
    /* Send tokens from the message sender's account to the specified account */
    function sendTokens(address receiver, uint amount) public {
        // if sender does not have enough money
        if (balances[msg.sender] < amount) return;
        
        // take funds out of sender's account
        balances[msg.sender] -= amount;
        
        // add those funds to receipient's account
        balances[receiver] += amount;

        emit TransferGB(msg.sender, receiver, amount);
    }
    
    function getBalance(address addr) public view returns (uint) {
        return balances[addr];
    }

    function buyTokensWithEther() public payable {
        uint numTokens = msg.value / TOKEN_PRICE_IN_WEI;
        
        // take funds out of sender's account
        balances[tokenFundsAddress] -= numTokens;
        balances[msg.sender] += numTokens;

        emit FundsRaised(msg.sender, msg.value, numTokens);
    }
}
