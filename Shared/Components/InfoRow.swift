//
//  InfoRow.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/8/22.
//

import SwiftUI

struct InfoRow: View {
    let title: String
    let subtitle: String
    let imageName: String
    @State var showAll: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.bottom, 2)
                .lineLimit(showAll ? 3 : 1)
                .fixedSize(horizontal: false, vertical: showAll ? true : false)
            HStack(alignment: .top) {
                Image(systemName: imageName)
                Text(subtitle)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: showAll ? true : false)
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .onTapGesture {
            withAnimation {
                showAll.toggle()
            }
        }
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(title: "Contract", subtitle: "0x29340823492834nc3r8932r", imageName: "doc.plaintext.fill")
    }
}
