//
//  RootView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/1/22.
//

import SwiftUI

struct RootView: View {
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
#endif

    enum Tab {
        case home
        case mint
        case account
    }

    @State private var selection: Tab = .home
    @StateObject private var userStore = UserStore()
    @StateObject private var nftStore = NFTStore()
    @State private var errorWrapper: ErrorWrapper?
    @State var showNFT = false

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                HomeView(nfts: $nftStore.nftFeed, searchResults: $nftStore.searchResults, showNFT: $showNFT)
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
            .environmentObject(nftStore)
            .environmentObject(userStore)

            NavigationView {
                MintView()
            }
            .tabItem {
                Label {
                    Text("Mint",
                         comment: "Mint NFT tab")
                } icon: {
                    Image(systemName: "plus.app")
                }
            }
            .tag(Tab.mint)
            .environmentObject(nftStore)
            .environmentObject(userStore)

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
            .environmentObject(userStore)

        }
        .accentColor(Color.azureBlue)
        .task {
            do {
                nftStore.nftFeed = try await nftStore.getNFTFeed()
            } catch {
                print(error)
                errorWrapper = ErrorWrapper(error: error, guidance: "There was a problem fetching your feed.")
            }
        }
        .sheet(item: $errorWrapper, onDismiss: {
            // fall back to mock data
            nftStore.nftFeed = NFT.mockData
        }) { wrapper in
            ErrorView(errorWrapper: wrapper)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
