//
//  ApiClient.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation

protocol ApiClient {
    
    func generateWallet() -> Wallet
    func getWallet(walletId: String) -> Wallet
    
    func mintNFT(user: User, mintNFTRequest: MintNFTRequest) -> NFT
    func getAllNFTs() -> [NFT]
    func getNFT(nftId: String) -> NFT
    func getUserNFTs(walletId: String) -> [NFT]
    func listNFT(nftId: String, listPrice: Double) -> NFT
    func buyNFT(nftId: String, sellerWalletId: String, buyerWalletId: String) -> NFT
}
