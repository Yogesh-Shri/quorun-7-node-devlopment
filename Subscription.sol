pragma solidity ^0.8.0;

contract Subscription {
    address public owner;
    uint256 public subscriptionFee;
    uint256 public subscriptionDuration;
    uint256 public subscribersCount;
    mapping(address => bool) public subscribers;
    mapping(address => uint256) public subscriptionExpiration;

    event SubscriptionTransferred(address indexed previousSubscriber, address indexed newSubscriber, uint256 expirationDate);
    event SubscriptionRenewed(address indexed subscriber, uint256 expirationDate);
    event SubscriptionCanceled(address indexed subscriber);

    constructor() {
        owner = msg.sender;
        subscriptionFee = 1 ether;
        subscriptionDuration = 30 days;
    }

    function subscribe() public payable {
        require(msg.value == subscriptionFee, "Incorrect subscription fee amount.");
        require(!subscribers[msg.sender], "You are already subscribed.");

        subscribers[msg.sender] = true;
        subscriptionExpiration[msg.sender] = block.timestamp + subscriptionDuration;
        subscribersCount++;

        emit SubscriptionRenewed(msg.sender, subscriptionExpiration[msg.sender]);
    }

    function transferSubscription(address _newSubscriber) public {
        require(subscribers[msg.sender], "You are not subscribed.");

        if (subscribers[_newSubscriber]) {
            subscriptionExpiration[_newSubscriber] += subscriptionDuration;
        } else {
            require(!subscribers[_newSubscriber], "New subscriber is already subscribed.");

            subscribers[_newSubscriber] = true;
            subscriptionExpiration[_newSubscriber] = block.timestamp + subscriptionDuration;
            subscribersCount++;
        }

        subscribers[msg.sender] = false;
        subscriptionExpiration[msg.sender] = 0;

        emit SubscriptionTransferred(msg.sender, _newSubscriber, subscriptionExpiration[_newSubscriber]);

        subscribersCount--;
    }

    function unsubscribe() public {
        require(subscribers[msg.sender], "You are not subscribed.");

        subscribers[msg.sender] = false;
        subscriptionExpiration[msg.sender] = 0;
        subscribersCount--;

        payable(msg.sender).transfer(subscriptionFee);

        emit SubscriptionCanceled(msg.sender);
    }

    function renewSubscription() public payable {
        require(msg.value == subscriptionFee, "Incorrect subscription fee amount.");
        require(subscribers[msg.sender], "You are not subscribed.");

        subscriptionExpiration[msg.sender] += subscriptionDuration;

        emit SubscriptionRenewed(msg.sender, subscriptionExpiration[msg.sender]);
    }

    function checkSubscriptionStatus() public view returns (bool) {
        return subscribers[msg.sender] && subscriptionExpiration[msg.sender] >= block.timestamp;
    }

    function changeSubscriptionFee(uint256 _newFee) public {
        require(msg.sender == owner, "Only the contract owner can change the subscription fee.");
        subscriptionFee = _newFee;
    }

    function changeSubscriptionDuration(uint256 _newDurationInDays) public {
        require(msg.sender == owner, "Only the contract owner can change the subscription duration.");
        subscriptionDuration = _newDurationInDays * 1 days;
    }

    function checkSubscriptionExpiration() public view returns (uint256) {
        require(subscribers[msg.sender], "You are not subscribed.");
        return subscriptionExpiration[msg.sender];
    }

    function getTotalSubscribers() public view returns (uint256) {
        return subscribersCount;
    }
}
