//
//  NFTStore.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/30/22.
//

import Foundation

class NFTStore: ObservableObject {
    private let apiClient: ApiClient
    @Published var nftFeed: [NFT] = []

    init(apiClient: ApiClient = HttpApiClient()) {
        self.apiClient = apiClient
    }

    func getNFTFeed() async throws -> [NFT] {
        var nfts = try await apiClient.getAllNFTs()
        nfts = nfts.sorted {
            $0.createdAt > $1.createdAt
        }
        return nfts
    }
}
