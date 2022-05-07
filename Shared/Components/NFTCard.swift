//
//  NFTCard.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/22/22.
//

import SwiftUI

struct NFTCard: View {
    @Binding var nft: NFT
    let namespace: Namespace.ID

    var body: some View {
        VStack {
            RemoteImage(urlString: nft.metadata.image)
                .scaledToFill()
                .matchedGeometryEffect(id: "\(nft.id)", in: namespace)
        }
        .matchedGeometryEffect(id: "vstack\(nft.id)", in: namespace)
        .frame(minHeight: 200, maxHeight: 400)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(.white, lineWidth: 1))
        .overlay(                VStack {
            Spacer()
            UserInfoCard(nft: nft, namespace: namespace, showAll: false)
                .matchedGeometryEffect(id: "userinfocard\(nft.id)", in: namespace)
                .padding(5)
        })
        .shadow(color: Color.mineBlack.opacity(0.1), radius: 15, x: 0, y: 5)
    }
}

struct NFTCard_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NFTCard(nft: .constant(NFT.mockData[0]), namespace: namespace)
            .padding(20)
    }
}

struct UserInfoCard: View {
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
                    Image("eth")
                        .offset(x: 5)
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
