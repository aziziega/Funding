// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

//import dari github AggregatorV3Interface
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    // We could make this public, but then we'd have to deploy it
    function getPrice() internal view returns (uint256) {
        // Address dari harga : 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF (zksync sepolia Testnet)
        // ABI
        // Sepolia ETH / USD Address
        // https://docs.chain.link/data-feeds/price-feeds/addresses
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate in 18 digit
        return uint256(answer * 10000000000);
    }

    // 1000000000
    function getConversionRate(
        // price ETH di konversi ke USD
        // 1e18 = 1000000000000000000
        uint256 ethAmount
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversion rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }
}

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    // Could we make this constant?  /* hint: no! We should make it immutable! */
    address public immutable i_owner;  // immutable - untuk menghemat gas fee pada address
    
    // 5 * (10 ** 18) atau 5 * 1e18
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;  // constant - untuk menghemat gas fee pada variabel

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {

        // allow user to send $
        // minimum $5 pengiriman

        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more ETH!"); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 * 18
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value; // addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        funders.push(msg.sender);
    }

    // apa itu revert? 
    // Membatalkan tindakan apa pun yang telah dilakukan, dan mengirim kembali sisa gas
    // Undo any action that have been done, and send the remaining gas back

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        return priceFeed.version();
    }

    modifier onlyOwner() {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert NotOwner();
        _; // _; = mengeksekusi source kode setelah kode diatasnya, begitupun sebaliknya

    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset array
        funders = new address[](0);

        // withdrawl dana 

        /* 
        3 Hal dalam Withdrawl 
        
        transfer
        send
        call

        */

        // // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \
    //         yes  no
    //         /     \
    //    receive()?  fallback()
    //     /   \
    //   yes   no
    //  /        \
    //receive()  fallback()

    // apa yang terjadi ketika seseorang mengirmkan kontrak ETH ini, tanpa memanggil fungsi dari fund
    // 2 spesial function di solidity sama 1 lagu constructor berarti 3.
    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}