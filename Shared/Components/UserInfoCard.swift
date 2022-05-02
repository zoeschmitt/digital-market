//
//  UserInfoCard.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/30/22.
//

import SwiftUI

struct UserInfoCard: View {
    let nft: NFT

    var body: some View {
        HStack {
            Text(nft.metadata.name)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()
            if nft.isListed {
                Image("eth")
                Text("\(String(format: "%.1f", nft.listPrice)) ETH")
                    .font(.subheadline)
                    .padding(.zero)
                    .foregroundColor(.mineBlack)
            }
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(.white, lineWidth: 1))
    }
}

struct UserInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.dodgerPurple)
            VStack {
                Spacer()
                UserInfoCard(nft: NFT.mockData[0])
                    .padding(5)
            }
        }
        .frame(height: 300)
        .padding()
    }
}
