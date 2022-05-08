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

    func searchNFTs(_ input: String) {
        searchResults = nftFeed.filter { $0.metadata.name.contains(input) }
    }

    func mintNFT(image: UIImage, name: String, description: String) async throws {

    }
}
