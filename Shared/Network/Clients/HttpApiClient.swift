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

    func generateWallet() async throws -> String {
        let fallback = "\(Wallet.mockData[0].id)"
        let urlRequest = self.postRequest(endpoint: "createWallet")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return fallback }
        let decodedWallet = try JSONDecoder().decode(Dictionary<String, String>.self, from: data)
        let walletId = decodedWallet["walletId"] ?? fallback
        return walletId
    }
    
    func getWallet(_ walletId: String) async throws -> Wallet {
        let urlRequest = self.getRequest(endpoint: "getWallet?walletId=\(walletId)")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return Wallet.mockData[0] }
        let decodedWallet = try JSONDecoder().decode(Wallet.self, from: data)
        return decodedWallet
    }
    
    func mintNFT(walletId: String, name: String, description: String, image: String) async throws {
        let requestObject = MintNFTRequest(metadata: MintNFTRequest.Metadata(name: name, description: description), filename: "nft.jpeg", image: image)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let requestData = try encoder.encode(requestObject)
        let urlRequest = self.postRequest(endpoint: "createNFT?walletId=\(walletId)", encodedBody: requestData)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            let error = try JSONDecoder().decode(Dictionary<String, String>.self, from: data)
            print(error)
            return
        }
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
        let urlRequest = self.getRequest(endpoint: "getUserNFTs?walletId=\(walletId)")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return NFT.mockData }
        let decodedNFTs = try JSONDecoder().decode([NFT].self, from: data)
        return decodedNFTs
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
        print(response)
    }
}

extension HttpApiClient {
    func postRequest(endpoint: String, body: Any? = nil, encodedBody: Data? = nil) -> URLRequest {
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
        if encodedBody != nil {
            urlRequest.httpBody = encodedBody
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
