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

    var body: some View {
        GeometryReader { geo in
            VStack {
                if image == nil {
                    Spacer()
                    SelectImage(showSheet: $showSheet)
                    Spacer()
                } else {
                    MintInfo(image: $image, nameInput: $nameInput, descriptionInput: $descriptionInput, geometry: geo)
                    Spacer()
                    HStack {
                        Button(action: { image = nil }) {
                            HStack {
                                Spacer()
                                Text("Cancel")
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .overlay(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(Color.azureBlue, lineWidth: 2))
                        }
                        Spacer()
                        Button(action: {}) {
                            HStack {
                                Text("Mint!")
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous).stroke(Color.azureBlue, lineWidth: 2).background(Color.azureBlue))
                            .clipShape(RoundedRectangle(cornerRadius: buttonsBorderRadius, style: .continuous))
                        }
                    }
                    .padding(.bottom, 40)
                    .padding(.horizontal, horizontalPadding)
                }
            }
            .sheet(isPresented: $showSheet) {
                ImagePicker(selectedImage: self.$image)
            }
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
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
            }
            .frame(width: 150, height: 150)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: uploadImageBorderRadius, style: .continuous))
            .clipShape(RoundedRectangle(cornerRadius: uploadImageBorderRadius, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: uploadImageBorderRadius, style: .continuous).stroke(Color.azureBlue, style: StrokeStyle(lineWidth: 2, dash: [10])))
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
        VStack {
            Image(uiImage: image!)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width - (horizontalPadding * 2), height: geometry.size.height / 1.5)
                .clipShape(RoundedRectangle(cornerRadius: imageBorderRadius, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: imageBorderRadius, style: .continuous).stroke(.white, lineWidth: 1))
                .padding(.horizontal, horizontalPadding)
            TextField("Name", text: $nameInput)
                .font(.opensans(.medium, size: 18))
            TextField("Description", text: $descriptionInput)
                .font(.opensans(.medium, size: 18))
        }
    }
}
