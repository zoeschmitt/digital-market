//
//  HttpApiClient.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation

class HttpApiClient: ApiClient {
    func generateWallet() -> Wallet {
        return mockWallet
    }
    
    func getWallet(walletId: String) -> Wallet {
        return mockWallet
    }
    
    func mintNFT(user: User, mintNFTRequest: MintNFTRequest) -> NFT {
        return mockNFT
    }
    
    func getAllNFTs() -> [NFT] {
        return [mockNFT]
    }
    
    func getNFT(nftId: String) -> NFT {
        return mockNFT
    }
    
    func getUserNFTs(walletId: String) -> [NFT] {
        return [mockNFT]
    }
    
    func listNFT(nftId: String, listPrice: Double) -> NFT {
        return mockNFT
    }
    
    func buyNFT(nftId: String, sellerWalletId: String, buyerWalletId: String) -> NFT {
        return mockNFT
    }
    
}
