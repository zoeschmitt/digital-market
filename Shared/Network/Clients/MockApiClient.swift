//
//  MockApiClient.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation

class MockApiClient: ApiClient {
    func generateWallet() -> Wallet {
        <#code#>
    }
    
    func getWallet(walletId: String) -> Wallet {
        <#code#>
    }
    
    func mintNFT(user: User, mintNFTRequest: MintNFTRequest) -> NFT {
        <#code#>
    }
    
    func getAllNFTs() -> [NFT] {
        <#code#>
    }
    
    func getNFT(nftId: String) -> NFT {
        <#code#>
    }
    
    func getUserNFTs(walletId: String) -> [NFT] {
        <#code#>
    }
    
    func listNFT(nftId: String, listPrice: Double) -> NFT {
        <#code#>
    }
    
    func buyNFT(nftId: String, sellerWalletId: String, buyerWalletId: String) -> NFT {
        <#code#>
    }
    

}
