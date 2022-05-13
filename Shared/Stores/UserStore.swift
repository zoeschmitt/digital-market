//
//  UserStore.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/30/22.
//

import Foundation

class UserStore: ObservableObject {
    private let apiClient: ApiClient
    @Published var walletId: String = ""

    init(apiClient: ApiClient = HttpApiClient()) {
        self.apiClient = apiClient
    }

    func checkForExistingWallet() async throws -> String? {
        var walletId = try await fetchUserWalletId()
        if walletId == nil {
            let wallet = try await generateUserWallet()
            storeUserWalletId(wallet)
            walletId = wallet
        }
        return walletId
    }

    func fetchUserWallet(_ walletId: String) async throws -> Wallet? {
        return try await apiClient.getWallet(walletId)
    }

    func generateUserWallet() async throws -> String {
        let wallet = try await apiClient.generateWallet()
        storeUserWalletId(wallet)
        return wallet
    }

    func fetchUserWalletId() async throws -> String? {
        return UserDefaults.standard.string(forKey: "walletId")
    }

    private func storeUserWalletId(_ id: String) {
        UserDefaults.standard.set(id, forKey: "walletId")
    }

    func getBalance() async throws -> Wallet.Balance {
        return try await apiClient.getBalance(walletId: walletId)
    }
}
