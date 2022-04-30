//
//  NFTView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/30/22.
//

import SwiftUI

struct NFTView: View {
    @Binding var nft: NFT

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NFTView_Previews: PreviewProvider {
    static var previews: some View {
        NFTView(nft: .constant(NFT.mockData[0]))
    }
}
