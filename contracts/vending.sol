// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract VendingMachine {
  
  // Store the owner of this smart contract
  address payable public owner;

  // A mapping is a key/value store.
  // Here we store cupcake balance of this smart contract.
  mapping (address payable user => uint amount) public cupcakeBalances;

  // Events are necessary for The Graph to create entities
  event Refill(uint amount, uint remaining, uint timestamp, uint blockNumber);
  event Purchase(address buyer, uint amount, uint remaining, uint timestamp, uint blockNumber);

  // When 'VendingMachine' contract is deployed:
  // 1. set the deploying address as the owner of the contract
  // 2. set the deployed smart contract's cupcake balance to 100
  constructor() {
    owner = payable(msg.sender);
    payable(cupcakeBalances[owner]) = 100;
  }

  // Allow the owner to increase the smart contract's cupcake balance
  function refill(uint amount) public {
    require(msg.sender == owner, "You aren't the owner");
    payable(cupcakeBalances[owner]) += amount;
    emit Refill(amount, cupcakeBalances[owner], block.timestamp, block.number);
  }

  // Allow anyone to purchase cupcakes
  function purchase(uint amount) public payable {
    require(msg.value >= amount * 0.01 ether, "You must pay at least 0.01 ETC per cupcake");
    require(cupcakeBalances[owner] >= amount, "Not enough cupcakes in stock to complete this purchase");
    payable(cupcakeBalances[owner]) -= amount;
    payable(cupcakeBalances[msg.sender]) += amount;
    emit Purchase(msg.sender, amount, cupcakeBalances[owner], block.timestamp, block.number);
  }
}
