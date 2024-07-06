// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./subscription.sol";
import "./profile.sol";

contract Nftmarketplace is RRC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private nftAvailableForSale;
    Counters.Counter private userIds;
    constructor()ERC721("NFT Magazine Subcription", "MAG"){
        tokenIds.increment();
        userIds.increment();

    }
    struct nftStruct {
         uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        address[] subscribers;
        uint256 likes;
        string title;
        string description;
        string tokenUri;
    }
    mapping(uint256 => nftStruct) private nfts;

    event NftStructCreated(
        uint256 indexed tokenId,
        address payable seller,
        address payable owner,
        uint256 price,
        address[] subscribers,
        uint256 likes,
        string title,
        string description
    );
    
    function setNft(
        uint256 _tokenId,
        string memory _title,
        string memory _description,
        string memory _tokenURI
    ) private {

        nfts[_tokenId].tokenId = _tokenId;
        nfts[_tokenId].seller = payable(msg.sender);
        nfts[_tokenId].owner = payable(msg.sender);
        nfts[_tokenId].price = 0;
        nfts[_tokenId].likes = 1;
        nfts[_tokenId].title = _title;
        nfts[_tokenId].description = _description;
        nfts[_tokenId].tokenUri = _tokenURI;


        emit NftStructCreated(
            _tokenId,
            payable(msg.sender),
            payable(msg.sender),
            0,
            nfts[_tokenId].subscribers,
            nfts[_tokenId].likes,
            _title,
            _description
        );
    }

}