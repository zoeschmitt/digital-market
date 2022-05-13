//
//  NFTCard.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/22/22.
//

import SwiftUI

struct NFTCard: View {
    @Binding var nft: NFT
    let namespace: Namespace.ID
    let borderRadius: CGFloat = 25

    var body: some View {
        VStack {
            RemoteImage(urlString: nft.metadata.image, namespace: namespace)
                .scaledToFill()
                .frame(minHeight: 200, maxHeight: 400)
                .frame(maxWidth: .infinity)
                .mask(RoundedRectangle(cornerRadius: borderRadius, style: .continuous).matchedGeometryEffect(id: "mask\(nft.id)", in: namespace))
                .overlay(RoundedRectangle(cornerRadius: borderRadius, style: .continuous).stroke(.white, lineWidth: 1))
                .overlay(                VStack {
                    Spacer()
                    NFTDetails(nft: nft, namespace: namespace, showAll: false)
                        .matchedGeometryEffect(id: "userinfocard\(nft.id)", in: namespace)
                        .padding(5)
                })
                .shadow(color: Color.mineBlack.opacity(0.1), radius: 15, x: 0, y: 5)
                .contentShape(RoundedRectangle(cornerRadius: borderRadius, style: .continuous))
        }
    }
}

struct NFTCard_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NFTCard(nft: .constant(NFT.mockData[0]), namespace: namespace)
            .padding(20)
    }
}
