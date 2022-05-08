//
//  Title.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/1/22.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.dodgerPurple)
                .opacity(0.2)
            Image("planet")
                .resizable()
                .frame(width: 25, height: 25)
        }
        .frame(width: 41, height: 41)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
