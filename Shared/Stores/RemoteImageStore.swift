//
//  RemoteImageStore.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/4/22.
//

import SwiftUI


struct RemoteImage: View {
    @ObservedObject var remoteImageModel: RemoteImageStore
    var placeholderImage: String

    init(urlString: String,
         withPlaceholderURL placeholderURL: String = "") {
        remoteImageModel = RemoteImageStore(urlString: urlString)
        placeholderImage = placeholderURL
    }

    var body: some View {
        if remoteImageModel.image == nil {
            if remoteImageModel.noImageFound == true {
                RemoteImage(urlString: placeholderImage)
            } else {
                ProgressView()
                    .padding()
            }
        } else {
            Image(uiImage: remoteImageModel.image!)
                .resizable()
        }
    }
}

class RemoteImageStore: ObservableObject {
    @Published var image: UIImage?
    @Published var noImageFound = false
    var urlString: String?
    var imageCache = ImageCache.getImageCache()

    init(urlString: String) {
        self.urlString = urlString
        loadImage()
    }

    private func loadImage() {
        if loadImageFromCache() {
            return
        }
        loadImageFromUrl()
    }

    private func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }

        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }

        image = cacheImage
        return true
    }

    private func loadImageFromUrl() {
        guard let urlString = urlString else {
            DispatchQueue.main.async { self.noImageFound = true }
            return
        }
        guard urlString != "" else {
            DispatchQueue.main.async { self.noImageFound = true }
            return
        }
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!,
                                              completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }

    private func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            DispatchQueue.main.async { self.noImageFound = true }
            return
        }
        guard let data = data else {
            print("No data found")
            DispatchQueue.main.async { self.noImageFound = true }
            return
        }

        if let response = response as? HTTPURLResponse {
            if response.statusCode != 200 {
                DispatchQueue.main.async { self.noImageFound = true }
            }
        }

        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
    }
}
