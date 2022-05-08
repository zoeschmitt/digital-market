//
//  NFTView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/7/22.
//

import SwiftUI

struct NFTView: View {
    let nft: NFT
    let namespace: Namespace.ID
    let geometry: GeometryProxy

    @State var fullImageHeight: Bool = false

    @Binding var showNFT: Bool

    let imageBorderRadius: CGFloat = 25
    private let openSeaURL = Configuration.stringValue(forKey: "OPENSEA_URL")
    private let polygonScanURL = Configuration.stringValue(forKey: "POLYGON_SCAN_URL")

    var body: some View {
        ZStack {
            VStack {
                RemoteImage(urlString: nft.metadata.image)
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                    .frame(maxHeight: fullImageHeight ? geometry.size.height : geometry.size.height  / 2)
                    .mask(RoundedRectangle(cornerRadius: imageBorderRadius, style: .continuous))
                    .matchedGeometryEffect(id: "\(nft.id)", in: namespace)
                    .onTapGesture {
                        withAnimation {
                            fullImageHeight.toggle()
                        }
                    }

                VStack(alignment: .center) {
                    UserInfoCard(nft: nft, namespace: namespace, showAll: true)
                        .matchedGeometryEffect(id: "userinfocard\(nft.id)", in: namespace)
                    Text("View On")
                    HStack {
                        Link("OpenSea", destination: URL(string: "\(openSeaURL)/\(nft.contract)/\(nft.tokenId)")!)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .background(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(Color.opensea, lineWidth: 2).background(Color.opensea))
                            .clipShape(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))

                        Link("Polygon Scan", destination: URL(string: "\(polygonScanURL)/\(nft.transactionHash)")!)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .background(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(Color.polygon, lineWidth: 2).background(Color.polygon))
                            .clipShape(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))
                    }
                }
                .padding(.horizontal, 15)
                .offset(y: -50)

                Spacer()
            }

            VStack {
                HStack(alignment: .top) {
                    Spacer()
                    Button(action: { withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        showNFT.toggle()
                        fullImageHeight = false
                    } }) {
                        Image(systemName: "xmark")
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .foregroundColor(Color.mineBlack)
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct NFTView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        GeometryReader { proxy in
            NFTView(nft: NFT.mockData[0], namespace: namespace, geometry: proxy, showNFT: .constant(true))
        }
    }
}
