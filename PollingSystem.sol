
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PollingSystem {
    struct Poll {
        string title;
        string[] options;
        uint256 endTime;
        mapping(uint256 => uint256) voteCount;
        mapping(address => bool) hasVoted;
        bool exists;
    }

    mapping(uint256 => Poll) private polls;
    uint256 public pollCount;

    event PollCreated(uint256 indexed pollId, string title);
    event VoteCast(uint256 indexed pollId, address indexed voter, uint256 optionIndex);

    function createPoll(
        string memory _title,
        string[] memory _options,
        uint256 _durationInMinutes
    ) public {
        require(bytes(_title).length > 0, "Title is required");
        require(_options.length >= 2, "At least two options required");
        require(_durationInMinutes > 0, "Duration must be positive");

        uint256 pollId = pollCount;
        Poll storage newPoll = polls[pollId];

        newPoll.title = _title;
        newPoll.endTime = block.timestamp + (_durationInMinutes * 1 minutes);
        newPoll.exists = true;

        for (uint256 i = 0; i < _options.length; i++) {
            require(bytes(_options[i]).length > 0, "Empty option");
            newPoll.options.push(_options[i]);
        }

        pollCount++;
        emit PollCreated(pollId, _title);
    }

    function vote(uint256 _pollId, uint256 _optionIndex) public {
        Poll storage currentPoll = polls[_pollId];

        require(currentPoll.exists, "Poll does not exist");
        require(block.timestamp < currentPoll.endTime, "Poll has ended");
        require(!currentPoll.hasVoted[msg.sender], "Already voted");
        require(_optionIndex < currentPoll.options.length, "Invalid option");

        currentPoll.hasVoted[msg.sender] = true;
        currentPoll.voteCount[_optionIndex]++;

        emit VoteCast(_pollId, msg.sender, _optionIndex);
    }

    function getPoll(uint256 _pollId)
        public
        view
        returns (
            string memory title,
            string[] memory options,
            uint256 endTime
        )
    {
        Poll storage currentPoll = polls[_pollId];
        require(currentPoll.exists, "Poll does not exist");

        return (
            currentPoll.title,
            currentPoll.options,
            currentPoll.endTime
        );
    }

    function getVotes(uint256 _pollId, uint256 _optionIndex)
        public
        view
        returns (uint256)
    {
        require(polls[_pollId].exists, "Poll does not exist");
        require(_optionIndex < polls[_pollId].options.length, "Invalid option");

        return polls[_pollId].voteCount[_optionIndex];
    }

    function getWinner(uint256 _pollId)
        public
        view
        returns (string memory winningOption, uint256 winningVotes)
    {
        Poll storage currentPoll = polls[_pollId];

        require(currentPoll.exists, "Poll does not exist");
        require(block.timestamp >= currentPoll.endTime, "Poll is still active");

        uint256 highestVotes = 0;
        uint256 winnerIndex = 0;

        for (uint256 i = 0; i < currentPoll.options.length; i++) {
            if (currentPoll.voteCount[i] > highestVotes) {
                highestVotes = currentPoll.voteCount[i];
                winnerIndex = i;
            }
        }

        return (currentPoll.options[winnerIndex], highestVotes);
    }
}
