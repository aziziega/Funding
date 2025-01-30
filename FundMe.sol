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

error notOwner();

contract FundMe {
    using PriceConverter for uint256;

    // 5 * (10 ** 18) atau 5 * 1e18
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    // constant - untuk menghemat gas fee pada variabel

    address[] public funders;
    mapping (address => uint256 amountFunded) public addressToAmountFunded;

    address public immutable owner;
    // immutable - untuk menghemat gas fee pada address

    constructor () {
        owner = msg.sender;
    }

    function fund() public payable {

        // allow user to send $
        // minimum $5 pengiriman
        // 1. how do we send ETH to this contract
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Pengiriman ETH Kurang"); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 * 18
        
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
        // addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;


    // apa itu revert? 
    // Membatalkan tindakan apa pun yang telah dilakukan, dan mengirim kembali sisa gas
    // Undo any action that have been done, and send the remaining gas back

    }

    

    function withdrawl() public onlyOwner {
        // for loop
        // for(/* start index, ending index, step amount increment atau decrement */)
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // Reset Array
        funders = new address [](0);

        // withdrawl dana 

        /* 
        3 Hal dalam Withdrawl 
        
        send
        call
        */

        // Transfer
        // msg.sender = adress
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
        revert();
    }

    modifier onlyOwner() {
        // require(msg.sender == owner, "Harus menjadi Owner!");
        if(msg.sender != owner) {
            revert notOwner();
        }
        _;
        // _; = mengeksekusi source kode setelah kode diatasnya, begitupun sebaliknya
    }

    // apa yang terjadi ketika seseorang mengirmkan kontrak ETH ini, tanpa memanggil fungsi dari fund
    // 2 spesial function di solidity
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}

