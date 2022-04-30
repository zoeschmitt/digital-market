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

    func getNFTFeed() async throws {
        nftFeed = try await apiClient.getAllNFTs()
        print(nftFeed)
    }
}
