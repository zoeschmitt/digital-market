//
//  Wallet.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation

struct Wallet {
    var walletId: String
    var address: String
    var privateKey: String
    var mnemonic: String
}

let mockWallet = Wallet(walletId: "385411dd-bb35-4071-b4fb-1e1b07626661", address: "0x0803723EEf4b628ba66e8D3eB93c049De82C98a9", privateKey: "0x05e4f0987d9f71c31700ddcdb04f9e46c3967729ffe450b23aa278d2aacaabd8", mnemonic: "sail whip palm transfer seat fence satisfy crack family brain boil describe")
let mockWalletArray = [Wallet(walletId: "385411dd-bb35-4071-b4fb-1e1b07626661", address: "0x0803723EEf4b628ba66e8D3eB93c049De82C98a9", privateKey: "0x05e4f0987d9f71c31700ddcdb04f9e46c3967729ffe450b23aa278d2aacaabd8", mnemonic: "sail whip palm transfer seat fence satisfy crack family brain boil describe"), Wallet(walletId: "385412dd-bb35-4071-b4fb-1e1b07626661", address: "0x0903723EEf4b628ba66e8D3eB93c049De82C98a9", privateKey: "0x05e4f1987d9f71c31700ddcdb04f9e46c3967729ffe450b23aa278d2aacaabd8", mnemonic: "sail whip dog transfer seat fence satisfy crack family brain boil describe"), Wallet(walletId: "385411dd-bb35-4071-b4fb-1e1b07626661", address: "0x0843723EEf4b628ba66e8D3eB93c049De82C98a9", privateKey: "0x05e4f0987d9f71c31700ddcdb04f9e46c3967729ffe450b23a5278d2aacaabd8", mnemonic: "sail whip cat transfer seat fence satisfy crack family brain boil describe")]
