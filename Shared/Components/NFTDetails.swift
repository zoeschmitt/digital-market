//
//  UserInfoCard.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/8/22.
//

import SwiftUI


struct NFTDetails: View {
    let nft: NFT
    let namespace: Namespace.ID
    let showAll: Bool

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(nft.metadata.name)
                        .matchedGeometryEffect(id: "name\(nft.id)", in: namespace)
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(nft.metadata.description)
                        .matchedGeometryEffect(id: "description\(nft.id)", in: namespace)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .lineLimit(showAll ? nil : 1)
                }
                Spacer()
                if nft.isListed {
                    Image("matic")
                    Text("\(String(format: "%.1f", nft.listPrice)) ETH")
                        .font(.subheadline)
                        .padding(.zero)
                        .foregroundColor(.mineBlack)
                }
                if !showAll {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                }
            }
            if showAll {
                Divider()
                HStack {
                    Text("Minted On")
                        .font(.caption)
                    Spacer()
                    Text(nft.mintedDate)
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(.white, lineWidth: 1))
    }
}


struct UserInfoCard_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NFTDetails(nft: NFT.mockData[0], namespace: namespace, showAll: false)
    }
}
