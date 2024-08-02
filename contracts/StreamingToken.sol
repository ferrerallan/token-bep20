// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StreamingToken is ERC20, Ownable {
    uint256 public rewardAmount;
    mapping(address => bool) public rewarded;
    mapping(address => bool) public reviewed;
    mapping(address => uint256) public referrals;
    mapping(uint256 => uint256) public votes;
    uint256 public totalVotes;
    uint256[] private votedMovieIds; // Lista de IDs de filmes votados

    event RewardGiven(address indexed user, uint256 amount);
    event ReviewRewardGiven(address indexed user, uint256 amount);
    event ReferralRewardGiven(address indexed user, uint256 amount);
    event Voted(uint256 indexed movieId, uint256 votes);

    constructor() ERC20("StreamingToken", "STK") Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10 ** 18);
        rewardAmount = 100 * 10 ** 18; 
    }

    // Reward to watch a movie
    function rewardUser(address user) external onlyOwner {
        require(!rewarded[user], "User has already been rewarded");
        _mint(user, rewardAmount);
        rewarded[user] = true;
        emit RewardGiven(user, rewardAmount);
    }

    // Reward to review a title
    function rewardReview(address user) external onlyOwner {
        require(!reviewed[user], "User has already been rewarded for review");
        _mint(user, rewardAmount);
        reviewed[user] = true;
        emit ReviewRewardGiven(user, rewardAmount);
    }

    // Reward to referral a friend
    function rewardReferral(address user, uint256 numberOfReferrals) external onlyOwner {
        _mint(user, rewardAmount * numberOfReferrals);
        referrals[user] += numberOfReferrals;
        emit ReferralRewardGiven(user, rewardAmount * numberOfReferrals);
    }

    // Vote function
    function voteForMovie(uint256 movieId) external {
        require(balanceOf(msg.sender) >= rewardAmount, "Not enough tokens to vote");
        _burn(msg.sender, rewardAmount);
        votes[movieId] += 1;
        totalVotes += 1;
        emit Voted(movieId, votes[movieId]);
    }

    // Define the amount of reward
    function setRewardAmount(uint256 amount) external onlyOwner {
        rewardAmount = amount;
    }

    function getAllVotes() external view returns (uint256[] memory, uint256[] memory) {
        uint256[] memory movieIds = new uint256[](votedMovieIds.length);
        uint256[] memory movieVotes = new uint256[](votedMovieIds.length);

        for (uint256 i = 0; i < votedMovieIds.length; i++) {
            movieIds[i] = votedMovieIds[i];
            movieVotes[i] = votes[votedMovieIds[i]];
        }

        return (movieIds, movieVotes);
    }
}
