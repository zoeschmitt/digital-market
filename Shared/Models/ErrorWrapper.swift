//
//  Error.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/29/22.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error?
    let guidance: String

    init(id: UUID = UUID(), error: Error? = nil, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
