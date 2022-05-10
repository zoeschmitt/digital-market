//
//  AccountView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import SwiftUI

struct AccountView: View {
    @State var wallet: Wallet

    var body: some View {
        VStack(alignment: .center) {
            Text("Address")
//            Text(wallet.address)
        }
        .task {
            do {

            } catch {
                
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(wallet: Wallet.mockData[0])
    }
}
