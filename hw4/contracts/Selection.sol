pragma solidity ^0.8.13;
 
contract Selection {
   
    struct Candidate {
        string name;
        uint voteCount;
    }
 
    address public manager;
    Candidate[] public candidates;
    mapping(address => bool) public voters;
    constructor() {
        manager = msg.sender;
    }
    function addCandidate(string memory name) public {
        require(msg.sender == manager, "Only the manager can add candidates");
        candidates.push(Candidate(name, 0));
    }
    function vote(uint candidateIndex) public {
        require(!voters[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Candidate not found");
 
        candidates[candidateIndex].voteCount++;
        voters[msg.sender] = true;
    }
    function getWinner() public view returns (string memory) {
        uint maxVotes = 0;
        uint winnerIndex = 0;
 
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }
        return candidates[winnerIndex].name;
    }
}