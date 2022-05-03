//
//  HomeView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import SwiftUI

struct HomeView: View {
    @Binding var nfts: [NFT]
    @State var showSearch = false
    @State var showNFT = false
    @State var selectedNFT: NFT?
    let gradient = Gradient(colors: [Color.mineBlack.opacity(0.05), Color.white])
    @Namespace var namespace

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack() {
                    LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                        .frame(width: geometry.size.width, height: geometry.size.height / 2)
                    Spacer()
                }
                .ignoresSafeArea()
                if (showNFT && selectedNFT != nil) {
                    ScrollView {
                        VStack {
                            RemoteImage(urlString: selectedNFT!.metadata.image)
                                .frame(height: geometry.size.height / 2)
                            Spacer()
                        }
                        .matchedGeometryEffect(id: "\(selectedNFT!.id)", in: namespace)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showNFT.toggle()
                            }
                        }
                    }
                } else {
                    ScrollView {
                        HStack(alignment: .center) {
                            if (!showNFT) {
                                if (!showSearch) {
                                    Text("Marketplace")
                                        .font(.opensans(.semibold, size: 26))
                                    Spacer()
                                }
                                SearchBar(showSearch: $showSearch)
                                    .matchedGeometryEffect(id: "search", in: namespace)
                            }
                        }
                        .padding(20)

                        ForEach($nfts) { $nft in
                            NFTCard(nft: $nft, namespace: namespace)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        showNFT.toggle()
                                        selectedNFT = nft
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
        HomeView(nfts: .constant(NFT.mockData))
    }
}

struct SearchBar: View {
    @Binding var showSearch: Bool
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.dodgerPurple)
                .padding(.leading, showSearch ? 10 : 0)
            if (showSearch) {
                Spacer()
            }
        }
        .frame(height: 45)
        .frame(maxWidth: showSearch ? .infinity : 45)
        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.dodgerPurple, lineWidth: 1))
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onTapGesture {
            withAnimation(.easeInOut) {
                showSearch.toggle()
            }
        }
    }
}
