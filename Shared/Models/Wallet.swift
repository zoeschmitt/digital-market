//
//  Wallet.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation

struct Wallet: Identifiable, Codable {
    var id: UUID
    var address: String?
    var privateKey: String?
    var mnemonic: String?

    init(id: UUID = UUID(), address: String?, privateKey: String?, mnemonic: String?) {
        self.id = id
        self.address = address
        self.privateKey = privateKey
        self.mnemonic = mnemonic
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "walletId", address, privateKey, mnemonic
    }
}

extension Wallet {
    struct Balance: Codable {
        var balance: String
        var address: String
    }
}

extension Wallet {
    static let mockData: [Wallet] = [
        Wallet(id: UUID(uuidString: "385411dd-bb35-4071-b4fb-1e1b07626661")!, address: "0x0803723EEf4b628ba66e8D3eB93c049De82C98a9", privateKey: "0x05e4f0987d9f71c31700ddcdb04f9e46c3967729ffe450b23aa278d2aacaabd8", mnemonic: "sail whip palm transfer seat fence satisfy crack family brain boil describe"), Wallet(id: UUID(uuidString: "385412dd-bb35-4071-b4fb-1e1b07626661")!, address: "0x0903723EEf4b628ba66e8D3eB93c049De82C98a9", privateKey: "0x05e4f1987d9f71c31700ddcdb04f9e46c3967729ffe450b23aa278d2aacaabd8", mnemonic: "sail whip dog transfer seat fence satisfy crack family brain boil describe"), Wallet(id: UUID(uuidString: "385411dd-bb35-4071-b4fb-1e1b07626661")!, address: "0x0843723EEf4b628ba66e8D3eB93c049De82C98a9", privateKey: "0x05e4f0987d9f71c31700ddcdb04f9e46c3967729ffe450b23a5278d2aacaabd8", mnemonic: "sail whip cat transfer seat fence satisfy crack family brain boil describe")
    ]
    static let mockBalance: Wallet.Balance = Wallet.Balance(balance: "1.0", address: "0x0803723EEf4b628ba66e8D3eB93c049De82C98a9")
}
