// SPDX-License-Identifier: sahil
pragma solidity ^ 0.7.6;
contract auction{
    address payable beneficiary;
    mapping(address => uint) public pendingReturns;
    uint public highestBid;
    address public highestBidder;
    uint public AuctionEndtime;
    event bidderChanged(address bidder , uint amount);
    event end( address winner , uint Amount);
    
    constructor(address payable _beneficiary) public {
        beneficiary = _beneficiary;
       // AuctionEndtime = block.timestamp + _biddingTime;
        
    }
    
    function bidding() public payable{
        
        require(msg.value > highestBid , "less than highest bid");
        //require(block.timestamp < AuctionEndtime ,"auction ended");
        
        if(highestBid!=0){
            pendingReturns[highestBidder] += highestBid; 
        }
        
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit bidderChanged(msg.sender , msg.value );
    }
    function withdraw() public returns(bool){
       uint amount = pendingReturns[msg.sender];
       if(amount > 0)
       {
           pendingReturns[msg.sender] = 0;
           if(msg.sender.send(amount) == false){
               pendingReturns[msg.sender] = amount;
               return false;
           }
       }
       return true;
    }
    function win() public {
        //require( block.timestamp > AuctionEndtime , "auction is in progress");
        emit end(highestBidder , highestBid);
        beneficiary.transfer(highestBid);
    }

}
