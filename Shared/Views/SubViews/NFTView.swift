//
//  NFTView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/7/22.
//

import SwiftUI

struct NFTView: View {
    let nft: NFT
    let namespace: Namespace.ID
    let geometry: GeometryProxy

    @State var fullImageHeight: Bool = false
    @State var showBuyAlert: Bool = false
    @State var showListAlert: Bool = false
    @State private var errorWrapper: ErrorWrapper?
    @State var listPrice: String = "0.0"

    @Binding var showNFT: Bool

    @EnvironmentObject var nftStore: NFTStore
    @EnvironmentObject var userStore: UserStore

    let imageBorderRadius: CGFloat = 25
    private let openSeaURL = Configuration.stringValue(forKey: "OPENSEA_URL")
    private let polygonScanURL = Configuration.stringValue(forKey: "POLYGON_SCAN_URL")
    let gradient = Gradient(colors: [Color.mineBlack.opacity(0.05), Color.white])

    var body: some View {
        ZStack {
            VStack {
                RemoteImage(urlString: nft.metadata.image, namespace: namespace)
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                    .frame(maxHeight: fullImageHeight ? geometry.size.height : geometry.size.height  / 2)
                    .mask(RoundedRectangle(cornerRadius: imageBorderRadius, style: .continuous).matchedGeometryEffect(id: "mask\(nft.id)", in: namespace))
                    .onTapGesture {
                        withAnimation {
                            fullImageHeight.toggle()
                        }
                    }

                details

                Spacer()
            }

            VStack {
                HStack(alignment: .top) {
                    Spacer()
                    Button(action: { withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        showNFT.toggle()
                        fullImageHeight = false
                    } }) {
                        Image(systemName: "xmark")
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: generalBorderRadius, style: .continuous))
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: generalBorderRadius, style: .continuous).stroke(.white, lineWidth: 1))
                    }
                }
                .padding()
                Spacer()
            }
        }
        .sheet(item: $errorWrapper) { wrapper in
            ErrorView(errorWrapper: wrapper)
        }
    }

    var details: some View {
        VStack(alignment: .leading) {
            NFTDetails(nft: nft, namespace: namespace, showAll: true)
                .matchedGeometryEffect(id: "userinfocard\(nft.id)", in: namespace)
                .padding(.bottom, 10)
            if userStore.walletId == nft.walletId && !nft.isListed {
                listButton
                    .padding(.vertical, 10)
            } else if nft.isListed && userStore.walletId != nft.walletId {
                buyButton
                    .padding(.vertical, 10)
            }
            Text("View On")
                .font(.opensans(.semibold, size: 16))
            StyledLink(title: "OpenSea", url: URL(string: "\(openSeaURL)/\(nft.contract)/\(nft.tokenId)")!, accentColor: Color.opensea)
            StyledLink(title: "Polygon Scan", url: URL(string: "\(polygonScanURL)/\(nft.transactionHash)")!, accentColor: Color.polygon)
            Text("Details")
                .font(.opensans(.semibold, size: 16))
                .padding(.vertical, 10)
            VStack {
                InfoRow(title: "Contract", subtitle: nft.contract, imageName: "doc.plaintext.fill")
                Divider()
                    .padding(.vertical, 10)
                InfoRow(title: "Transaction Hash", subtitle: nft.transactionHash, imageName: "number.circle.fill")
            }
            .padding(20)
            .background(.ultraThinMaterial)
            .mask(RoundedRectangle(cornerRadius: generalBorderRadius, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: generalBorderRadius, style: .continuous).stroke(.white, lineWidth: 1))

            Text("Royalties")
                .font(.opensans(.semibold, size: 16))
                .padding(.vertical, 10)

            ForEach(nft.royalties, id: \.recipient ) { royalty in
                InfoRow(title: royalty.recipient, subtitle: "\(royalty.percentage)", imageName: "percent")
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: generalBorderRadius, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: generalBorderRadius, style: .continuous).stroke(.white, lineWidth: 1))
            }


        }
        .padding(.horizontal, 15)
        .offset(y: fullImageHeight ? -5 : -50)
    }

    var buyButton: some View {
        HStack(alignment: .top) {
            Button(action: { withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showBuyAlert = true
            } }) {
                PrimaryButton(title: "Buy")
            }
            .alert("Buy \(nft.metadata.name) for \(String(format: "%.1f ETH", nft.listPrice))?", isPresented: $showBuyAlert) {
                Button("Buy") {
                    Task {
                        do {
                            try await nftStore.buyNFT(nft: nft, buyerWalletId: try await userStore.fetchUserWalletId()!)
                        } catch {
                            print(error)
                            errorWrapper = ErrorWrapper(error: error, guidance: "There was a problem fetching your feed.")
                        }
                    }
                }
                Button("Cancel", role: .cancel) { }
            }
        }
        .frame(maxWidth: .infinity)
    }

    var listButton: some View {
        HStack(alignment: .top) {
            Button(action: { withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showListAlert = true
            } }) {
                PrimaryButton(title: "List")
            }
            .alert("List \(nft.metadata.name)", isPresented: $showBuyAlert) {
                TextField("List Price", text: $listPrice)
                Button("List") {
                    Task {
                        do {
                            try await nftStore.listNFT(nftId: "\(nft.id)", listPrice: Double(listPrice)!)
                        } catch {
                            print(error)
                            errorWrapper = ErrorWrapper(error: error, guidance: "There was a problem listing your nft.")
                        }
                    }
                }
                Button("Cancel", role: .cancel) { }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct NFTView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        GeometryReader { proxy in
            NFTView(nft: NFT.mockData[0], namespace: namespace, geometry: proxy, showNFT: .constant(true))
        }
    }
}
