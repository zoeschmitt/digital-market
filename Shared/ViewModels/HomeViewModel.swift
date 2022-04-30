//
//  HomeViewModel.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let apiClient: ApiClient
    @Published private(set) var nftFeed: [NFT]?

    init(apiClient: ApiClient = HttpApiClient()) {
        self.apiClient = apiClient
        //getNFTFeed()
    }
    
//    private func getNFTFeed() {
//        nftFeed = apiClient.getAllNFTs()
//    }

}
