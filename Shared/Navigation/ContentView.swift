//
//  ContentView.swift
//  Shared
//
//  Created by Zoe Schmitt on 4/4/22.
//

import SwiftUI

struct ContentView: View {
    
    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif

    @StateObject var homeViewModel: HomeViewModel

    init(apiClient: ApiClient) {
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(apiClient: apiClient))
    }

        var body: some View {
            TabBar()
                .environmentObject(homeViewModel)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(apiClient: MockApiClient())
    }
}
