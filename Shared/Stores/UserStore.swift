//
//  UserStore.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/30/22.
//

import Foundation

class UserStore: ObservableObject {
    private let apiClient: ApiClient
    @Published private(set) var walletId: String = ""

    init(apiClient: ApiClient = HttpApiClient()) {
        self.apiClient = apiClient
        Task {
            await checkForExistingWallet()
        }
    }

    private func checkForExistingWallet() async {
        do {
            var walletId = try await fetchUserWalletId()
            if walletId == nil {
                let wallet = try await generateUserWallet()
                storeUserWalletId("\(wallet.id)")
                walletId = "\(wallet.id)"
            }
            self.walletId = walletId!
        } catch {
            print(error)
        }
        print(walletId)
    }

    func fetchUserWallet(_ walletId: String) async throws -> Wallet? {
        return try await apiClient.getWallet(walletId)
    }

    func generateUserWallet() async throws -> Wallet {
        let wallet = try await apiClient.generateWallet()
        storeUserWalletId("\(wallet.id)")
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
