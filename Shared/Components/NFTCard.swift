//
//  NFTCard.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/22/22.
//

import SwiftUI

struct NFTCard: View {
    @Binding var nft: NFT
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.galleryGrey
                VStack {
                    AsyncImage(url: URL(string: nft.metadata.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                VStack {
                    Spacer()
                    UserInfoCard(nft: nft)
                }
                .padding(5)
            }
        }
        .frame(minHeight: 300)
        .frame(maxWidth: .infinity, maxHeight: 400)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(.white, lineWidth: 1))
        .shadow(color: Color.mineBlack.opacity(0.1), radius: 15, x: 0, y: 5)
    }
}

struct NFTCard_Previews: PreviewProvider {
    static var previews: some View {
        NFTCard(nft: .constant(NFT.mockData[0]))
            .padding(20)
    }
}
