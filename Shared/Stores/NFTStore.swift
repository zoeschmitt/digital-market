//
//  NFTStore.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/30/22.
//

import Foundation
import UIKit

class NFTStore: ObservableObject {
    private let apiClient: ApiClient
    @Published var nftFeed: [NFT] = []
    @Published var searchResults: [NFT] = []

    init(apiClient: ApiClient = HttpApiClient()) {
        self.apiClient = apiClient
    }

    func getNFTFeed() async throws -> [NFT] {
        return try await apiClient.getAllNFTs().sorted {
            $0.createdAt > $1.createdAt
        }
    }

    func getUserNFTs(walletId: String) async throws -> [NFT] {
        return try await apiClient.getUserNFTs(walletId)
    }

    func getNFT(nftId: String) async throws -> NFT {
        return try await apiClient.getNFT(nftId)
    }

    func searchNFTs(_ input: String) {
        searchResults = nftFeed.filter { $0.metadata.name.contains(input) }
    }

    func mintNFT(walletId: String, image: UIImage, name: String, description: String) async throws {
        let base64EncodedImg: String = image.base64!
        try await apiClient.mintNFT(walletId: walletId, name: name, description: description, image: base64EncodedImg)
    }

    func buyNFT(nft: NFT, buyerWalletId: String) async throws {
        try await apiClient.buyNFT(nftId: "\(nft.id)", sellerWalletId: nft.walletId, buyerWalletId: buyerWalletId)
    }

    func listNFT(nftId: String, listPrice: Double) async throws {
        try await apiClient.listNFT(nftId: nftId, listPrice: listPrice)
    }
}
