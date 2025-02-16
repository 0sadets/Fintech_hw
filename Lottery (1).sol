Завдання: 
Розробити смарт-контракт на Solidity для голосування, де користувачі можуть голосувати за кандидатів.
 
Функції: 
addCandidate(string memory name) - додає кандидата до списку
 
vote(string memory candidate) - додає голос за певного кандидата
 
getWinner() - визначає переможця за к-стю голосів
 
mapping(string => uint) public votes;
 
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Lottery {

address payable public winner;
address payable[] public members;
address public manager;

    constructor() {
        manager = msg.sender;
    }

    function join() payable public returns (bool) {
        
        require(msg.value==1 ether, "Please pay 1 ETH for join!");
        members.push(payable(msg.sender));
        return true;
    }

    function getBalance() public view returns(uint){
        require(manager==msg.sender, "You cannot show the balance!");
        return address(this).balance;
    }

    function random() public view returns(uint)
    {
        return uint(keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.prevrandao, // Use block.difficulty in older versions
                    msg.sender
                )
            )) % members.length;
    } 

    function roll() public {

        require(manager==msg.sender, "You cannot roll the drum!");

        uint index = random();
        winner = members[index];
        winner.transfer(getBalance());
        members=new address payable[](0);
    }
}