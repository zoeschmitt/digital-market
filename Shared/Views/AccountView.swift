//
//  AccountView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewModel = AccountViewModel()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: .init(apiClient: MockApiClient()))
    }
}
