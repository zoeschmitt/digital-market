//
//  Cache.swift
//  DigitalMarket
//
//  Created by Zoe Schmitt on 5/2/22.
//

import SwiftUI

class ImageCache {
    private var cache = NSCache<NSString, UIImage>()

    // If a memory warning is received, clean all cache
    init() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil,
            queue: .main) { [weak self] _ in
                self?.cache.removeAllObjects()
            }
    }

    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }

    func set(forKey key: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: key))
    }

    func delete(forKey key: String) {
        cache.removeObject(forKey: NSString(string: key))
    }

    func deleteAll() {
        cache.removeAllObjects()
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()

    static func getImageCache() -> ImageCache {
        return imageCache
    }
    static func deleteImageFromCache(imageURL: String) {
        imageCache.delete(forKey: imageURL)
    }
    static func deleteAll() {
        imageCache.deleteAll()
    }
}
