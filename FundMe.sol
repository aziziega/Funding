// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Mendapatkan Fund dari User
// Withdrawl Fund
// Set minimum Funding value ke USD

// interface AggregatorV3Interface {
//   function decimals() external view returns (uint8);

//   function description() external view returns (string memory);

//   function version() external view returns (uint256);

//   function getRoundData(
//     uint80 _roundId
//   ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

//   function latestRoundData()
//     external
//     view
//     returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
// }

//import dari github AggregatorV3Interface
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    // 5 * (10 ** 18) atau 5 * 1e18
    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping (address => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {

        // allow user to send $
        // minimum $5 pengiriman
        // 1. how do we send ETH to this contract
        require(msg.value.getConversionRate() >= minimumUsd, "Pengiriman ETH Kurang"); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 * 18
        
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
        // addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;


    // apa itu revert? 
    // Membatalkan tindakan apa pun yang telah dilakukan, dan mengirim kembali sisa gas
    // Undo any action that have been done, and send the remaining gas back

    }

    function wintrdrawl() public {
        // for loop
        // for(/* start index, ending index, step amount increment atau decrement */)
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
    }
}

