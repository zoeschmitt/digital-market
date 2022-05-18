//
//  SearchBar.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/5/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var showSearch: Bool
    @Binding var searchInput: String
    @EnvironmentObject var nftStore: NFTStore

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.azureBlue)
                .padding(.leading, showSearch ? 10 : 0)
                .accessibilityAddTraits(.isButton)
                .accessibilityIdentifier("searchButton")
            if (showSearch) {
                TextField("Search", text: $searchInput)
                    .onChange(of: searchInput) { input in
                        nftStore.searchNFTs(input)
                    }
                    .accessibilityAddTraits(.isSearchField)
                    .padding(.leading, 5)
                    .font(.opensans(.medium, size: 18))
                Image(systemName: "xmark")
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.azureBlue)
                    .padding(.trailing, 10)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showSearch.toggle()
                            searchInput = ""
                        }
                    }
                    .accessibilityAddTraits(.isButton)
                    .accessibilityLabel("Close Search")
                    .accessibilityIdentifier("closeSearchButton")
            }
        }
        .frame(height: 45)
        .frame(maxWidth: showSearch ? .infinity : 45)
        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.azureBlue, lineWidth: 1))
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onTapGesture {
            if (!showSearch) {
                withAnimation(.easeInOut) {
                    showSearch.toggle()
                }
            }
        }
        .accessibilityLabel("Search")
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(showSearch: .constant(false), searchInput: .constant(""))
    }
}
