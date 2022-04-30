//
//  ContentView.swift
//  Shared
//
//  Created by Zoe Schmitt on 4/4/22.
//

import SwiftUI

struct RootView: View {
    
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
#endif

    var body: some View {
        TabBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
