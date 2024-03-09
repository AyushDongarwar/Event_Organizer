// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract Eventorg{
    struct Event{
        address organizer;
        string name; 
        uint date;
        uint price;
        uint ticketcout;
        uint Ticketremain;
    }
    mapping(uint=>Event) public events;
    mapping(address=>mapping (uint=>uint)) public ticket;
    uint public nextId;

    function createEvent(string memory name, uint date, uint price, uint ticketcount) external {
        require(date > block.timestamp, "Event must be in the future");
        require(ticketcount>0,"Only if more than zero");

        events[nextId]=Event(msg.sender,name,date,price,ticketcount,ticketcount);
        nextId=nextId+1;
    }
    function buyticket(uint id, uint quantity) external payable   {
        require(events[id].date!=0,"event does not exist");
        require(events[id].date>block.timestamp,"event occured");
        Event storage _event= events[id];
        require(msg.value==_event.Ticketremain,"Not enough ethers");
        require(_event.Ticketremain>=quantity,"Not enough tickets");
        _event.Ticketremain==quantity;
        ticket[msg.sender][id]+=quantity;
    }
    function transfer(uint id,uint quantity, address to) external {
     require(events[id].date!=0,"Event does not exist");
     require(events[id].date>block.timestamp,"Event occured");
     require(ticket[msg.sender][id]>=quantity,"No enough ticket");
     ticket[msg.sender][id]-=quantity;
     ticket[to][id]+=quantity;
    }


}
