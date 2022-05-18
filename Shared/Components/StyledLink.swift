//
//  StyledLink.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/8/22.
//

import SwiftUI

struct StyledLink: View {
    let title: String
    let url: URL
    let accentColor: Color

    var body: some View {
        Link(destination: url) {
            Text(title)
                .font(.opensans(.semibold, size: 16))
            Spacer()
            Image(systemName: "arrow.up.forward.square.fill")
        }
        .padding(12)
        .foregroundColor(accentColor)
        .background(.ultraThinMaterial)
        .frame(maxWidth: .infinity)
        .mask(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(accentColor, lineWidth: 1))
    }
}

struct StyledLink_Previews: PreviewProvider {
    static var previews: some View {
        StyledLink(title: "Apple", url: URL(string: "apple.com")!, accentColor: Color.blue)
    }
}
