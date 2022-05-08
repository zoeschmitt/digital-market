//
//  ApiClient.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation

protocol ApiClient {
    
    func generateWallet() async throws -> Wallet
    func getWallet(walletId: String) async throws -> Wallet
    
    func mintNFT(name: String, description: String, filename: String, image: String) async throws -> NFT
    func getAllNFTs() async throws -> [NFT]
    func getNFT(nftId: String) async throws -> NFT
    func getUserNFTs(walletId: String) async throws -> [NFT]
    func listNFT(nftId: String, listPrice: Double) async throws -> NFT
    func buyNFT(nftId: String, sellerWalletId: String, buyerWalletId: String) async throws -> NFT
}
