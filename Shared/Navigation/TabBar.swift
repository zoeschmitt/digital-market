//
//  TabBar.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import SwiftUI

struct TabBar: View {

    enum Tab {
        case home
        case search
        case account
    }

    @State private var selection: Tab = .home

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                let menuText = Text("Home", comment: "Smoothie menu tab title")
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
                         comment: "Favorite smoothies tab title")
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
                         comment: "Smoothie rewards tab title")
                } icon: {
                    Image(systemName: "person.fill")
                }
            }
            .tag(Tab.account)
            
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
