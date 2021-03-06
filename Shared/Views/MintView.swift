//
//  MintView.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/3/22.
//

import SwiftUI

struct MintView: View {
    @State private var image: UIImage?
    @State private var showSheet = false
    @State private var nameInput = ""
    @State private var descriptionInput = ""
    @State private var inputValidationFailed = false
    @State private var loading = false
    @State private var success = false

    @EnvironmentObject var nftStore: NFTStore
    @EnvironmentObject var userStore: UserStore

    @State private var errorWrapper: ErrorWrapper?

    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    if image == nil {
                        Spacer()
                        SelectImage(showSheet: $showSheet)
                        Spacer()
                    } else {
                        MintInfo(image: $image, nameInput: $nameInput, descriptionInput: $descriptionInput, geometry: geo)
                            .padding(.bottom, 30)
                        Spacer()
                        HStack {
                            Button("Cancel", action: {
                                image = nil
                                nameInput = ""
                                descriptionInput = ""
                            })
                            .frame(maxWidth: .infinity)
                            .font(.opensans(.semibold, size: 16))
                            .padding(.vertical, 10)
                            .overlay(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(Color.azureBlue, lineWidth: 2))
                            Spacer()
                            Button("Mint!", action: {
                                if nameInput.isEmpty || descriptionInput.isEmpty {
                                    inputValidationFailed = true
                                    return
                                }
                                Task {
                                    loading = true
                                    do {
                                        try await nftStore.mintNFT(walletId: userStore.walletId, image: image!, name: nameInput, description: descriptionInput)
                                        image = nil
                                        nameInput = ""
                                        descriptionInput = ""
                                        success = true
                                        nftStore.nftFeed = try await nftStore.getNFTFeed()
                                    } catch NFT.NFTError.tooLarge {
                                        errorWrapper = ErrorWrapper(guidance: "Your photo is too large.")
                                    } catch {
                                        print(error)
                                        errorWrapper = ErrorWrapper(error: error, guidance: "There was a problem minting your NFT.")
                                    }
                                    loading = false
                                }
                            })
                            .frame(maxWidth: .infinity)
                            .font(.opensans(.semibold, size: 16))
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(Color.azureBlue, lineWidth: 2).background(Color.azureBlue))
                            .clipShape(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))
                        }
                        .padding(.bottom, 40)
                    }
                }
                if loading {
                    ProgressView()
                        .padding()
                }
            }
            .sheet(isPresented: $showSheet) {
                ImagePicker(selectedImage: self.$image)
            }
            .sheet(item: $errorWrapper) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.top, 50)
            .ignoresSafeArea(edges: .top)
            .frame(width: geo.size.width)
            .alert("Make sure to enter both a name and description for your NFT", isPresented: $inputValidationFailed) {
                Button("Okay", role: .cancel) { }
            }
            .alert("Successfully minted!", isPresented: $success) {
                Button("Done", role: .cancel) { }
            }
        }
    }
}

struct MintView_Previews: PreviewProvider {
    static var previews: some View {
        MintView()
    }
}

struct SelectImage: View {
    @Binding var showSheet: Bool
    let uploadImageBorderRadius: CGFloat = 27

    var body: some View {
        VStack {
            Button(action: { showSheet = true }) {
                VStack {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                }
                .frame(width: 150, height: 150)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: uploadImageBorderRadius, style: .continuous))
                .clipShape(RoundedRectangle(cornerRadius: uploadImageBorderRadius, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: uploadImageBorderRadius, style: .continuous).stroke(Color.azureBlue, style: StrokeStyle(lineWidth: 2, dash: [10])))
            }
            .accessibilityIdentifier("selectImage")
            .accessibilityLabel("Select Image Button")
            Text("Select Image")
                .font(.opensans(.semibold, size: 22))
                .accessibilityHidden(true)
        }
    }
}

struct MintInfo: View {
    @Binding var image: UIImage?
    @Binding var nameInput: String
    @Binding var descriptionInput: String
    let geometry: GeometryProxy
    let imageBorderRadius: CGFloat = 25

    var body: some View {
        if image != nil {
            VStack {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width - (horizontalPadding * 2))
                    .frame(maxHeight: 300)
                    .clipShape(RoundedRectangle(cornerRadius: imageBorderRadius, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: imageBorderRadius, style: .continuous).stroke(.white, lineWidth: 1))
                    .padding(.bottom, 30)
                TextField("Name", text: $nameInput)
                    .font(.opensans(.medium, size: 18))
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .frame(maxWidth: .infinity)
                    .mask(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))

                TextField("Description", text: $descriptionInput)
                    .font(.opensans(.medium, size: 18))
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .frame(maxWidth: .infinity)
                    .mask(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))
            }
        } else {
            Text("No Image Chosen")
                .font(.opensans(.semibold, size: 22))
        }
    }
}
