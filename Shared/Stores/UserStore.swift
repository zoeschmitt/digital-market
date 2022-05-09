//
//  UserStore.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/30/22.
//

import Foundation

class UserStore: ObservableObject {
    private let apiClient: ApiClient

    init(apiClient: ApiClient = HttpApiClient()) {
        self.apiClient = apiClient
    }

    func fetchUserWallet() async throws -> Wallet? {
        let walletId = try await fetchUserWalletId()
        if walletId != nil {
            //api call
        }
        return Wallet.mockData[0]
    }

    func generateUserWallet() async throws -> Wallet {
        let wallet = try await apiClient.generateWallet()
        storeUserWalletId("\(wallet.id)")
        return wallet
    }

    func fetchUserWalletId() async throws -> String? {
        return UserDefaults.standard.string(forKey: "walletId")
    }

    func storeUserWalletId(_ id: String) {
        UserDefaults.standard.set(id, forKey: "walletId")
    }
}
