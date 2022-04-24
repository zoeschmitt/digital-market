//
//  HomeView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Marketplace")
                    .font(.title)
                Spacer()
            }
            .background(.green)
            .padding(20)
            ScrollView (.vertical) {
                NFTCard()
                
            }
        }
        .background(.red)
        .background(.orange)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init(apiClient: MockApiClient()))
    }
}
