//
//  PrimaryButtonStyle.swift
//  DigitalMarket (iOS)
//
//  Created by Zoe Schmitt on 5/17/22.
//

import SwiftUI

struct PrimaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding(10)
            .font(.opensans(.semibold, size: 16))
            .frame(maxWidth: .infinity)
            .background(Color.azureBlue)
            .foregroundColor(.white)
            .mask(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(Color.azureBlue, lineWidth: 1))
    }
}
