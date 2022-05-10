//
//  UIImage+Base64.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/9/22.
//

import SwiftUI

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}
