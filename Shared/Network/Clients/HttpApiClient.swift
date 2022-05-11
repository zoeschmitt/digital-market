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

    func getBalance(walletId: String) async throws -> Wallet.Balance {
        let urlRequest = self.getRequest(endpoint: "getBalance?walletId=\(walletId)")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return Wallet.mockBalance }
        let decodedBalance = try JSONDecoder().decode(Wallet.Balance.self, from: data)
        return decodedBalance
    }

    func generateWallet() async throws -> Wallet {
        let urlRequest = self.postRequest(endpoint: "createWallet")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return Wallet.mockData[0] }
        let decodedWallet = try JSONDecoder().decode(Wallet.self, from: data)
        return decodedWallet
    }
    
    func getWallet(_ walletId: String) async throws -> Wallet {
        let urlRequest = self.getRequest(endpoint: "getWallet?walletId=\(walletId)")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return Wallet.mockData[0] }
        let decodedWallet = try JSONDecoder().decode(Wallet.self, from: data)
        return decodedWallet
    }
    
    func mintNFT(walletId: String, name: String, description: String, image: String) async throws {
        let urlRequest = self.postRequest(endpoint: "mintNFT?walletId=\(walletId)", body: ["metadata": ["name": name, "description": description], "filename": "nft.jpeg", "image": image])
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else { fatalError() }
    }
    
    func getAllNFTs() async throws -> [NFT] {
        let urlRequest = self.getRequest(endpoint: "getAllNFTs")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return NFT.mockData }
        let decodedWallet = try JSONDecoder().decode([NFT].self, from: data)
        return decodedWallet
    }
    
    func getNFT(_ nftId: String) async throws -> NFT {
        let urlRequest = self.getRequest(endpoint: "getNFT?nftId=\(nftId)")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return NFT.mockData[0] }
        let decodedNFT = try JSONDecoder().decode(NFT.self, from: data)
        return decodedNFT
    }
    
    func getUserNFTs(_ walletId: String) async throws -> [NFT] {
//        let urlRequest = self.getRequest(endpoint: "getNFT?walletId=\(walletId)")
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return NFT.mockData }
//        let decodedNFTs = try JSONDecoder().decode([NFT].self, from: data)
//        return decodedNFTs
        return NFT.mockData
    }
    
    func listNFT(nftId: String, listPrice: Double) async throws {
        let urlRequest = self.postRequest(endpoint: "listNFT?nftId=\(nftId)", body: ["listPrice": "\(String(format: "%.1f ETH", listPrice))"])
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else { fatalError() }
    }
    
    func buyNFT(nftId: String, sellerWalletId: String, buyerWalletId: String) async throws {
        let urlRequest = self.postRequest(endpoint: "buyNFT?nftId=\(nftId)", body: ["sellerWalletId": sellerWalletId, "buyerWalletId": buyerWalletId])
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200
        else { fatalError() }
    }
}

extension HttpApiClient {
    func postRequest(endpoint: String, body: Any? = nil) -> URLRequest {
        let url = URL(string: "\(baseURL)/\(endpoint)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        urlRequest.httpMethod = "POST"
        if body != nil {
            let bodyData = try? JSONSerialization.data(
                withJSONObject: body as Any,
                options: []
            )
            urlRequest.httpBody = bodyData
        }
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
