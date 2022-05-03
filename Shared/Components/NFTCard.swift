//
//  NFTCard.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/22/22.
//

import SwiftUI

struct NFTCard: View {
    @Binding var nft: NFT
    @Namespace var namespace
    
    var body: some View {
        VStack {
            RemoteImage(urlString: nft.metadata.image)
        }
        .frame(minHeight: 300, idealHeight: 500, maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(.white, lineWidth: 1))
        .overlay(                VStack {
            Spacer()
            UserInfoCard(nft: nft)
                .padding(5)
        })
        .shadow(color: Color.mineBlack.opacity(0.1), radius: 15, x: 0, y: 5)

    }
}

struct NFTCard_Previews: PreviewProvider {
    static var previews: some View {
        NFTCard(nft: .constant(NFT.mockData[0]))
            .padding(20)
    }
}
