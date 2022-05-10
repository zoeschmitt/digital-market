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
            // log
        }
        print(walletId)
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

    private func storeUserWalletId(_ id: String) {
        UserDefaults.standard.set(id, forKey: "walletId")
    }
}
