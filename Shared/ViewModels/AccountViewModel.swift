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

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

    private func getUserWalletId(walletId: String) {
        if let userWallet = Configuration.stringValue(forKey: "walletId") as String? {
            wallet?.walletId = userWallet
        }
    }

    func getUserWallet() {
        if wallet?.walletId != nil {
            //api call
        }
    }

    func generateUserWallet() {

    }
}
