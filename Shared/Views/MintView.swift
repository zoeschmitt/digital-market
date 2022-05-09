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

    @EnvironmentObject var nftStore: NFTStore
    @EnvironmentObject var userStore: UserStore

    @State private var errorWrapper: ErrorWrapper?

    var body: some View {
        GeometryReader { geo in
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
                        Button(action: {
                            image = nil
                            nameInput = ""
                            descriptionInput = ""
                        }) {
                            HStack {
                                Spacer()
                                Text("Cancel")
                                    .font(.opensans(.semibold, size: 16))
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .overlay(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(Color.azureBlue, lineWidth: 2))
                        }
                        Spacer()
                        Button(action: {
                            Task {
                                do {
                                    try await nftStore.mintNFT(image: image!, name: nameInput, description: descriptionInput)
                                } catch {
                                    print(error)
                                    errorWrapper = ErrorWrapper(error: error, guidance: "There was a problem minting your NFT.")
                                }
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Mint!")
                                    .font(.opensans(.semibold, size: 16))
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(Color.azureBlue, lineWidth: 2).background(Color.azureBlue))
                            .clipShape(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))
                        }
                    }
                    .padding(.bottom, 40)
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
            Text("Select Image")
                .font(.opensans(.semibold, size: 22))
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
                    .frame(maxHeight: .infinity)
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
