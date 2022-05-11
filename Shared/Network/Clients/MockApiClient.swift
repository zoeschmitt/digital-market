//
//  MockApiClient.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation

class MockApiClient: ApiClient {

    func getBalance(walletId: String) async throws -> Wallet.Balance {
        return Wallet.mockBalance
    }

    func generateWallet() async throws -> Wallet {
        return Wallet.mockData[0]
    }

    func getWallet(_ walletId: String) async throws -> Wallet {
        return Wallet.mockData[0]
    }

    func mintNFT(walletId: String, name: String, description: String, image: String) async throws {}

    func getAllNFTs() async throws -> [NFT] {
        return NFT.mockData
    }

    func getNFT(_ nftId: String) async throws -> NFT {
        return NFT.mockData[0]
    }

    func getUserNFTs(_ walletId: String) async throws -> [NFT] {
        return NFT.mockData
    }

    func listNFT(nftId: String, listPrice: Double) async throws {}

    func buyNFT(nftId: String, sellerWalletId: String, buyerWalletId: String) async throws {}
}
