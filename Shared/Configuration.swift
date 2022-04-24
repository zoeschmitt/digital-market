//
//  Configuration.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/23/22.
//

import Foundation

class Configuration {
    static func stringValue(forKey key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
