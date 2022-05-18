//
//  ListView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/13/22.
//

import SwiftUI

struct ListNFTView: View {
    let nft: NFT

    @Environment(\.dismiss) private var dismiss

    @State private var listPrice: Double = 0
    @State private var err: String = ""
    @State private var loading: Bool = false
    @State private var success = false

    @EnvironmentObject var nftStore: NFTStore

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Text("List \(nft.metadata.name)?")
                        .font(.title)
                        .padding(.bottom)
                    RemoteImage(urlString: nft.metadata.image)
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: geometry.size.height  / 2)
                        .mask(RoundedRectangle(cornerRadius: imageBorderRadius, style: .continuous))
                        .padding()
                    TextField("List Price", value: $listPrice, format: .number)
                        .font(.opensans(.medium, size: 18))
                        .padding()
                        .background(.ultraThinMaterial)
                        .frame(minWidth: 100)
                        .mask(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))
                        .padding()
                    if !err.isEmpty {
                        Text(err)
                            .font(.caption)
                            .padding(.bottom)
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button("List", action: {
                        Task {
                            loading = true
                            err = ""
                            do {
                                try await nftStore.listNFT(nftId: "\(nft.id)", listPrice: listPrice)
                                success = true
                                nftStore.nftFeed = try await nftStore.getNFTFeed()
                            } catch {
                                print(error)
                                err = "There was a problem listing your NFT"
                            }
                            loading = false
                        }
                    })
                    .modifier(PrimaryButtonStyle())
                    .padding()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
                .alert("Successfully listed!", isPresented: $success) {
                    Button("Done", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListNFTView(nft: NFT.mockData[0])
    }
}
