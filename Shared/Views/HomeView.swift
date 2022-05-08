//
//  HomeView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import SwiftUI

struct HomeView: View {
    @Namespace var namespace

    @Binding var nfts: [NFT]
    @Binding var searchResults: [NFT]

    @State var showSearch = false
    @Binding var showNFT: Bool
    @State var selectedNFT: NFT?
    @State private var searchInput: String = ""

    let gradient = Gradient(colors: [Color.mineBlack.opacity(0.05), Color.white])

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.5)
                    Spacer()
                }
                .ignoresSafeArea()
                ScrollView {
                    if (!showNFT) {
                        HStack(alignment: .center) {
                            if (!showNFT) {
                                if (!showSearch) {
                                    Text("Marketplace")
                                        .font(.opensans(.semibold, size: 26))
                                    Spacer()
                                }
                                SearchBar(showSearch: $showSearch, searchInput: $searchInput)
                                    .matchedGeometryEffect(id: "search", in: namespace)
                            }
                        }
                        .padding(20)
                    }
                    if (showNFT && selectedNFT != nil) {
                        NFTView(nft: selectedNFT!, namespace: namespace, geometry: geometry, showNFT: $showNFT)
                    } else {
                        ForEach(searchInput != "" ? $searchResults : $nfts) { $nft in
                            NFTCard(nft: $nft, namespace: namespace)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        selectedNFT = nft
                                        showNFT.toggle()
                                    }
                                }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(nfts: .constant(NFT.mockData), searchResults: .constant(NFT.mockData), showNFT: .constant(true))
    }
}
