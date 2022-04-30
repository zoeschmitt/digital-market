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
            Text("NFT")
                .font(.headline)

            Spacer()
            if nft.listPrice != nil && nft.listPrice != 0 {
                Image("eth")
                Text("\(String(format: "%.1f", nft.listPrice!)) ETH")
                    .font(.subheadline)
                    .padding(.zero)
            }
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))

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
