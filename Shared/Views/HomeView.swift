//
//  HomeView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Marketplace")
                    .font(.title)
                Spacer()
            }
            ScrollView (.vertical) {
                NFTCard()
                
            }
        }
        .padding(20)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
