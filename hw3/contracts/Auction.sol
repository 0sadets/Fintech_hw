// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Auction {
    address public owner;
    string public item;
    uint public minBid;
    uint public endTime;
    
    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public bids;
    bool public ended;
    bool public cancelled;
    
    event AuctionCreated(string item, uint minBid, uint endTime);
    event NewBid(address indexed bidder, uint amount);
    event AuctionEnded(address winner, uint amount);
    event AuctionCancelled();

    constructor(string memory _item, uint _minBid, uint _duration) {
        owner = msg.sender;
        item = _item;
        minBid = _minBid;
        endTime = block.timestamp + _duration;
        emit AuctionCreated(_item, _minBid, endTime);
    }

    function onlyOwner() private view {
        require(msg.sender == owner, "Only the owner can perform this action");
    }

    function auctionActive() private view {
        require(block.timestamp < endTime, "Auction end");
        require(!ended, "The auction has already ended.");
        require(!cancelled, "Auction canceled");
    }

    function bid() external payable {
        auctionActive();
        require(msg.value > minBid, "The bet must be greater than the minimum.");
        require(msg.value > highestBid, "The bet must be greater than the minimum.");
        
        if (highestBidder != address(0)) {
            bids[highestBidder] += highestBid; 
        }
        
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit NewBid(msg.sender, msg.value);
    }

    function withdraw() external {
        uint amount = bids[msg.sender];
        require(amount > 0, "No funds to withdraw");
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function endAuction() external {
        onlyOwner();
        require(block.timestamp >= endTime, "The auction has not ended yet.");
        require(!ended, "The auction has already ended.");
        
        ended = true;
        if (highestBidder != address(0)) {
            payable(owner).transfer(highestBid);
        }
        emit AuctionEnded(highestBidder, highestBid);
    }

    function cancelAuction() external {
        onlyOwner();
        auctionActive();
        
        cancelled = true;
        ended = true;
        emit AuctionCancelled();
    }
}
