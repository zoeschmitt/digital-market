//
//  HttpApiClient.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation

class HttpApiClient: ApiClient {
    private let baseURL = Configuration.stringValue(forKey: "API_URL")
    private let apiKey = Configuration.stringValue(forKey: "API_KEY")

    func generateWallet() async throws -> Wallet {
        let urlRequest = self.postRequest(endpoint: "createWallet")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return Wallet.mockData[0] }
        let decodedWallet = try JSONDecoder().decode(Wallet.self, from: data)
        return decodedWallet
    }
    
    func getWallet(walletId: String) async throws -> Wallet {
        let urlRequest = self.getRequest(endpoint: "getWallet?walletId=\(walletId)")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return Wallet.mockData[0] }
        let decodedWallet = try JSONDecoder().decode(Wallet.self, from: data)
        return decodedWallet
    }
    
    func mintNFT(user: User, mintNFTRequest: MintNFTRequest) async throws -> NFT {
        return NFT.mockData[0]
    }
    
    func getAllNFTs() async throws -> [NFT] {
//        let urlRequest = self.getRequest(endpoint: "getAllNFTs")
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return NFT.mockData }
//        let decodedWallet = try JSONDecoder().decode([NFT].self, from: data)
//        return decodedWallet
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
    
    func buyNFT(nftId: String, sellerWalletId: String, buyerWalletId: String) async throws -> NFT {
        return NFT.mockData[0]
    }
}

extension HttpApiClient {
    func postRequest(endpoint: String) -> URLRequest {
        let url = URL(string: "\(baseURL)/\(endpoint)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        urlRequest.httpMethod = "POST"
        return urlRequest
    }
    func getRequest(endpoint: String) -> URLRequest {
        let url = URL(string: "\(baseURL)/\(endpoint)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
}
