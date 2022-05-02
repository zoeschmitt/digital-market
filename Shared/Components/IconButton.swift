//
//  IconButton.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/1/22.
//

import SwiftUI

struct IconButton: View {
    let iconName: String

    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(Color.dodgerPurple)
            .frame(width: 40, height: 40)
            .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.dodgerPurple, lineWidth: 1))
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(iconName: "person.fill")
    }
}
