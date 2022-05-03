//
//  HomeView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import SwiftUI

struct HomeView: View {
    @Binding var nfts: [NFT]
    let gradient = Gradient(colors: [Color.mineBlack.opacity(0.05), Color.white])

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack() {
                    LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                        .frame(width: geometry.size.width, height: geometry.size.height / 2)
                    Spacer()
                }
                .ignoresSafeArea()
                ScrollView {
                    HStack(alignment: .center) {
//                        Logo()
                        Text("Marketplace")
                            .font(.opensans(.semibold, size: 26))
                        Spacer()
                        IconButton(iconName: "magnifyingglass")
                    }
                    .padding(20)

                    ForEach($nfts) { $nft in
                        NavigationLink(destination: NFTView(nft: nft)) {
                            NFTCard(nft: $nft)
                        }
                        .padding(.bottom, 8)
                    }
                    .padding(.horizontal, 20)
                }
                .navigationBarHidden(true)
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(nfts: .constant(NFT.mockData))
    }
}
