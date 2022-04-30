//
//  NFTCard.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/22/22.
//

import SwiftUI

struct NFTCard: View {
    let nft: NFT
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
            VStack {
                // image
            }
            VStack {
                Spacer()
                UserInfoCard(nft: nft)
            }
            .padding(5)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
    }
}

struct NFTCard_Previews: PreviewProvider {
    static var previews: some View {
        NFTCard(nft: NFT.mockData[0])
            .padding(20)
    }
}
