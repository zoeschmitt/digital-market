//
//  MintNFTRequest.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/10/22.
//

import Foundation

struct MintNFTRequest: Encodable {
    var metadata: Metadata
    var filename: String
    var image: String
}

extension MintNFTRequest {
    struct Metadata: Encodable {
        var name: String
        var description: String
    }
}
