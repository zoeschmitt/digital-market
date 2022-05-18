//
//  ObfuscatedField.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/13/22.
//

import SwiftUI

struct ObfuscatedField: View {
    @State var show: Bool = false
    let hiddenText: String
    let text: String

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: show ? "eye.fill" : "eye")
            Text(show ? hiddenText : text)
            Spacer()
        }
        .font(.caption)
        .foregroundColor(.secondary)
        .padding(15)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: generalBorderRadius, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: generalBorderRadius, style: .continuous).stroke(.white, lineWidth: 1))
        .onTapGesture {
            withAnimation {
                show.toggle()
            }
        }
        .accessibilityLabel("Tap to show \(text)")
        .accessibilityIdentifier("\(text)-shown-\(show)")
    }
}

struct ObfuscatedField_Previews: PreviewProvider {
    static var previews: some View {
        ObfuscatedField(hiddenText: "hidden", text: "hidden")
    }
}
