# CodeAlpha_PollingSystem

## Polling System Smart Contract

A Solidity-based smart contract that allows users to create polls, vote for their preferred options, and determine the winning option after the voting deadline.

Developed as part of the **CodeAlpha Blockchain Development Internship**.

## Features

- Create polls with a title and multiple voting options.
- Set a voting duration for each poll.
- Allow users to vote for their preferred option.
- Prevent users from voting more than once in the same poll.
- Prevent voting after the deadline.
- Track votes securely using Solidity mappings.
- Retrieve poll details and vote counts.
- Determine the winning option after the poll ends.

## Technologies Used

- Solidity
- Remix IDE
- Ethereum Virtual Machine (EVM)
- Remix VM for testing

## Smart Contract Functions

| Function | Description |
|---|---|
| `createPoll()` | Creates a poll with options and a voting duration. |
| `vote()` | Allows a user to vote for an option. |
| `getPoll()` | Returns poll details and options. |
| `getVotes()` | Returns the vote count for an option. |
| `getWinner()` | Returns the winning option after the poll ends. |

## Testing

The smart contract was compiled, deployed, and tested using Remix IDE with Remix VM.

The following tests were performed:

- Successful poll creation.
- Successful voting from different accounts.
- Vote count verification.
- Prevention of duplicate voting.
- Prevention of voting after the deadline.
- Rejection of invalid option indexes.
- Winner determination after the poll ends.

## Project Screenshots

The following screenshots demonstrate the contract code, deployment, poll creation, voting, vote counts, and winner result.

1. `PollingSystem_Code.png`
2. `PollingSystem_Deployment.png`
3. `PollingSystem_CreatePoll.png`
4. `PollingSystem_Voting.png`
5. `PollingSystem_VoteCounts.png`
6. `PollingSystem_Winner.png`

## Internship

**Program:** CodeAlpha Blockchain Development Internship

**Project:** Polling System Smart Contract

**Status:** Completed

## Disclaimer

This project was developed and tested in the Remix VM environment for educational purposes. It has not been deployed to a live Ethereum network.
