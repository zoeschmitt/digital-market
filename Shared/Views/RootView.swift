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

    enum Tab {
        case home
        case search
        case account
    }

    @State private var selection: Tab = .home
    @StateObject private var userStore = UserStore()
    @StateObject private var nftStore = NFTStore()
    @State private var errorWrapper: ErrorWrapper?

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                HomeView(nfts: $nftStore.nftFeed)
            }
            .tabItem {
                let menuText = Text("Home", comment: "Home NFT feed")
                Label {
                    menuText
                } icon: {
                    Image(systemName: "house.fill")
                }.accessibility(label: menuText)
            }
            .tag(Tab.home)

            NavigationView {
                SearchView()
            }
            .tabItem {
                Label {
                    Text("Search",
                         comment: "Search tab")
                } icon: {
                    Image(systemName: "magnifyingglass")
                }
            }
            .tag(Tab.search)

            NavigationView {
                AccountView()
            }
            .tabItem {
                Label {
                    Text("Account",
                         comment: "Account information tab")
                } icon: {
                    Image(systemName: "person.fill")
                }
            }
            .tag(Tab.account)

        }
        .task {
            do {
                try await nftStore.getNFTFeed()
            } catch {
                errorWrapper = ErrorWrapper(error: error, guidance: "There was a problem fetching your feed.")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
