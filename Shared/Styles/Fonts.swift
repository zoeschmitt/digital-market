//
//  Fonts.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/30/22.
//

import SwiftUI

extension Font {
    enum OpenSans {
        case light
        case regular
        case medium
        case semibold
        case bold
        case extrabold

        var value: String {
            switch self {
            case .light:
                return "OpenSans-Light"
            case .regular:
                return "OpenSans-Regular"
            case .medium:
                return "OpenSans-Medium"
            case .semibold:
                return "OpenSans-SemiBold"
            case .bold:
                return "OpenSans-Bold"
            case .extrabold:
                return "OpenSans-ExtraBold"
            }
        }
    }

    static func opensans(_ type: OpenSans, size: CGFloat = 20) -> Font {
        return .custom(type.value, size: size)
    }
}

extension UIFont {
    enum OpenSans {
        case light
        case regular
        case medium
        case semibold
        case bold
        case extrabold

        var value: String {
            switch self {
            case .light:
                return "OpenSans-Light"
            case .regular:
                return "OpenSans-Regular"
            case .medium:
                return "OpenSans-Medium"
            case .semibold:
                return "OpenSans-SemiBold"
            case .bold:
                return "OpenSans-Bold"
            case .extrabold:
                return "OpenSans-ExtraBold"
            }
        }
    }

    static func opensans(_ type: OpenSans, size: CGFloat = 20) -> Font {
        return .custom(type.value, size: size)
    }
}
