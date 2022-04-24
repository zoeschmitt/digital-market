//
//  NFT.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation


struct NFT {
    var nftId: String
    var walletId: String
    var network: String
    var contract: String
    var tokenId: String
    var transactionHash: String
    var filename: String
    var ipfsHash: String
    var createdAt: String
    var openseaURL: String
    var royalties: Royalties?
    var metadata: Metadata
    var isListed: Bool
    var listPrice: Double?
}

let mockNFT = NFT(nftId: "2e7c2a7f-a121-48c2-bdd6-7d52d3fb474e", walletId: "3940a896-a332-466b-93ca-8e28041613be", network: "maticmum", contract: "0x91dFa85B7795bdBcae325D3A73639b175CeC7175", tokenId: "1", transactionHash: "0xe4754bde02f1d98d28234c8e7988ab25fdfb45d74555f20d32c679ff9826e9b3", filename: "pug.png", ipfsHash: "bafyreig4wvcyy4dozouuunmajhxyakvaere24szdpdezezjbx7dl3ypmxi", createdAt: "2022-04-03T00:51:13.579Z", openseaURL: "https://testnets.opensea.io/assets/mumbai/0x91dFa85B7795bdBcae325D3A73639b175CeC7175/1", metadata: Metadata(name: "NFT", description: "NFT"), isListed: false)
