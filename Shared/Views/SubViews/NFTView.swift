//
//  NFTView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/30/22.
//

import SwiftUI

struct NFTView: View {
    let nft: NFT
    @Namespace var namespace

    var body: some View {
        GeometryReader { geometry in
            VStack {
                AsyncImage(url: URL(string: nft.metadata.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 1.5)
                .matchedGeometryEffect(id: "image", in: namespace)
            }
        }
    }
}

struct NFTView_Previews: PreviewProvider {
    static var previews: some View {
        NFTView(nft: NFT.mockData[0])
    }
}
