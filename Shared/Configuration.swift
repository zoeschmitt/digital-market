//
//  Configuration.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/23/22.
//

import Foundation

class Configuration {
    static func stringValue(forKey key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String
        else {
            fatalError("Invalid value or undefined key")
        }
        return value
    }
}
