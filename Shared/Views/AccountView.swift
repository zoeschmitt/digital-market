//
//  AccountView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 4/17/22.
//

import SwiftUI

struct AccountView: View {
    @State var balance: Wallet.Balance?
    @State var wallet: Wallet?
    @State var userNFTs: [NFT] = []
    @State private var errorWrapper: ErrorWrapper?
    @State var selectedNFT: NFT?
    @State var showNFT: Bool = false
    @State var showWalletAddress: Bool = false
    @State var showPrivateKey: Bool = false
    @State var showMnemonic: Bool = false

    @Namespace var namespace

    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var nftStore: NFTStore

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if (showNFT && selectedNFT != nil) {
                    NFTView(nft: selectedNFT!, namespace: namespace, geometry: geometry, showNFT: $showNFT)
                } else {
                    VStack(alignment: .center) {
                        if balance != nil {
                            Text("Address")
                                .font(.opensans(.semibold, size: 20))
                            Text(balance!.address)
                                .font(.opensans(.light, size: 18))
                                .foregroundColor(.gray)
                                .frame(width: showWalletAddress ? nil : geometry.size.width / 2)
                                .lineLimit(showWalletAddress ? 2 : 1)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    withAnimation {
                                        showWalletAddress.toggle()
                                    }
                                }
                            HStack {
                                Image("matic")
                                Text(balance!.balance)
                                    .font(.opensans(.light, size: 18))
                            }

                            if wallet == nil {
                                Button("Get Private Key", action: { Task {
                                    do {
                                        wallet = try await userStore.fetchUserWallet(userStore.walletId)
                                    } catch {
                                        print(error)
                                        errorWrapper = ErrorWrapper(error: error, guidance: "There was a problem fetching your wallet.")
                                    }
                                } })
                                .modifier(PrimaryButtonStyle())

                            }

                            if wallet != nil {
                                ObfuscatedField(show: $showPrivateKey, hiddenText: wallet!.privateKey, text: "Private Key")
                                    .onTapGesture {
                                        withAnimation {
                                            showPrivateKey.toggle()
                                        }
                                    }
                                ObfuscatedField(show: $showMnemonic, hiddenText: wallet!.mnemonic, text: "Mnemonic")
                                    .onTapGesture {
                                        withAnimation {
                                            showMnemonic.toggle()
                                        }
                                    }
                            }

                            Divider()
                                .padding(.vertical, 20)
                            Text("Your NFTs")
                                .font(.opensans(.semibold, size: 20))
                            if userNFTs.count > 0 {
                                LazyVGrid(columns: [GridItem(),GridItem(),GridItem()], spacing: 10) {
                                    ForEach($userNFTs) { $nft in
                                        VStack {
                                            RemoteImage(urlString: nft.metadata.image, namespace: namespace)
                                                .scaledToFill()
                                                .frame(width: 110, height: 150)
                                                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous).matchedGeometryEffect(id: "mask\(nft.id)", in: namespace))
                                                .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(.white, lineWidth: 1))
                                                .shadow(color: Color.mineBlack.opacity(0.1), radius: 15, x: 0, y: 5)
                                                .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                                .onTapGesture {
                                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                                        selectedNFT = nft
                                                        showNFT.toggle()
                                                    }
                                                }
                                        }
                                    }
                                }
                            } else {
                                Text("You dont have any NFTs yet!")
                            }

                        } else {
                            HStack() {
                                Spacer()
                                VStack {
                                    Spacer()
                                    ProgressView()
                                        .padding()
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding(20)
                }
            }
        }
        .task {
            do {
                balance = try await userStore.getBalance()
            } catch {
                print(error)
                errorWrapper = ErrorWrapper(error: error, guidance: "There was a problem fetching your wallet balance.")
            }
        }
        .task {
            do {
                userNFTs = try await nftStore.getUserNFTs(walletId: userStore.walletId)
            } catch {
                print(error)
                errorWrapper = ErrorWrapper(error: error, guidance: "There was a problem fetching your NFTs.")
            }
        }
        .sheet(item: $errorWrapper) { wrapper in
            ErrorView(errorWrapper: wrapper)
        }
        .navigationBarHidden(true)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(wallet: Wallet.mockData[0])
    }
}
