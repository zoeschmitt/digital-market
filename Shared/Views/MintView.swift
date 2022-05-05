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

    var body: some View {
        GeometryReader { geo in
            VStack {
                if image == nil {
                    Spacer()
                    Button(action: { showSheet = true }) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35)
                    }
                    .frame(width: 150, height: 150)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(Color.azureBlue, style: StrokeStyle(lineWidth: 2, dash: [10])))
                    Text("Select Image")
                        .font(.opensans(.semibold, size: 22))
                    Spacer()
                } else {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width - 40, height: geo.size.height / 1.5)
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(.white, lineWidth: 1))
                        .padding(.horizontal, 20)
                }

                if image != nil {
                    Spacer()
                    HStack {
                        Button(action: { image = nil }) {
                            HStack {
                                Spacer()
                                Text("Cancel")
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.azureBlue, lineWidth: 2))
                        }
                        Spacer()
                        Button(action: {}) {
                            HStack {
                                Spacer()
                                Text("Continue")
                                Image(systemName: "arrow.forward")
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.azureBlue, lineWidth: 2).background(Color.azureBlue))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
                    .padding(.bottom, 40)
                    .padding(.horizontal, 20)
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
