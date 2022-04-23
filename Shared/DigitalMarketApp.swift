//
//  DigitalMarketApp.swift
//  Shared
//
//  Created by Zoe Schmitt on 4/4/22.
//

import SwiftUI

@main
struct DigitalMarketApp: App {

#if DEBUG
    let apiClient: ApiClient = MockApiClient()
#else
    let apiClient: ApiClient = HttpApiClient()
#endif

    var body: some Scene {
        WindowGroup {
            ContentView(apiClient: apiClient)
        }
    }
}
