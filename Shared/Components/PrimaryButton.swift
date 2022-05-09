//
//  PrimaryButton.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/8/22.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var body: some View {
        Text(title)
            .padding(10)
            .font(.opensans(.semibold, size: 16))
            .frame(maxWidth: .infinity)
            .background(Color.azureBlue)
            .foregroundColor(.white)
            .mask(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(.white, lineWidth: 1))
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "NFT")
    }
}
