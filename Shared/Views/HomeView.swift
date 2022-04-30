//
//  HomeView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import SwiftUI

struct HomeView: View {
    @Binding var nfts: [NFT]

    var body: some View {
        ScrollView {
            HStack(alignment: .center) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.dodgerPurple)
                        .opacity(0.2)
                    Image("planet")
                }
                .frame(width: 40, height: 40)
                .padding(.trailing, 5)
                Text("Digital Assets")
                    .font(.opensans(.semibold, size: 24))
                Spacer()
            }
            .padding(20)

            ForEach($nfts) { $nft in
                NavigationLink(destination: NFTView(nft: $nft)) {
                    NFTCard(nft: nft)
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(nfts: .constant(NFT.mockData))
    }
}
