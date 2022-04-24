//
//  NFTCard.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/22/22.
//

import SwiftUI

struct NFTCard: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    VStack {
                        // profile image
                    }
                    .frame(width: 20, height: 20)
                    .background(.green)
                    
                    VStack (alignment: .leading) {
                        Text("Zoe Schmitt")
                            .font(.headline)
                        Text("@zoe")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Text("1 ETH")
                        .font(.subheadline)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                }
                .padding()
                .background(.red)
            }
            .padding(5)
            VStack {
                // image
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .background(.blue)
    }
}

struct NFTCard_Previews: PreviewProvider {
    static var previews: some View {
        NFTCard()
    }
}
