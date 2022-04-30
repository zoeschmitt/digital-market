//
//  AccountViewModel.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import Foundation

class AccountViewModel: ObservableObject {
    private let apiClient: ApiClient
    @Published private(set) var wallet: Wallet?

    init(apiClient: ApiClient = HttpApiClient()) {
        self.apiClient = apiClient
    }

    private func getUserWalletId(walletId: String) {

    }

    func fetchUserWallet() async throws -> Wallet? {
        let walletId = try await fetchUserWalletId()
        if walletId != nil {
            //api call
        }
    }

    func generateUserWallet() async throws -> Wallet {
        return try await apiClient.generateWallet()
    }

    private func fetchUserWalletId() async throws -> String? {
        return UserDefaults.standard.string(forKey: "walletId")
    }

    private func storeUserWalletId(_ id: String) {
        UserDefaults.standard.set(id, forKey: "walletId")
    }
}
