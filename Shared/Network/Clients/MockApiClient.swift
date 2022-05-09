//
//  MockApiClient.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation

class MockApiClient: ApiClient {

    func generateWallet() async throws -> Wallet {
        return Wallet.mockData[0]
    }

    func getWallet(walletId: String) async throws -> Wallet {
        return Wallet.mockData[0]
    }

    func mintNFT(name: String, description: String, filename: String, image: String) async throws -> NFT {
        return NFT.mockData[0]
    }

    func getAllNFTs() async throws -> [NFT] {
        return NFT.mockData
    }

    func getNFT(nftId: String) async throws -> NFT {
        return NFT.mockData[0]
    }

    func getUserNFTs(walletId: String) async throws -> [NFT] {
        return NFT.mockData
    }

    func listNFT(nftId: String, listPrice: Double) async throws -> NFT {
        return NFT.mockData[0]
    }

    func buyNFT(nftId: String, sellerWalletId: String, buyerWalletId: String) async throws -> Bool {
    }
}
