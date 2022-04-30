//
//  Royalties.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/5/22.
//

import Foundation

struct Royalties: Codable {
    var id: UUID
    var recipient: String
    var percentage: String

    init(id: UUID = UUID(), recipient: String, percentage: String) {
        self.id = id
        self.recipient = recipient
        self.percentage = percentage
    }
}
