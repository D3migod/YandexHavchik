//
//  CacheProvider.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 28/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation

private class LazyImageCache {
    var type: ImageCache.Type
    init(_ type: ImageCache.Type) {
        self.type = type
    }
    lazy var imageCache = type.init()
}

enum ImageCacheFramework: Int, CaseIterable {
    case Kingfisher
    case SDWebImage
    case Nuke
    
    func getAssociatedCache() -> ImageCache.Type {
        switch self {
        case .Kingfisher:
            return KingfisherCache.self
        case .SDWebImage:
            return SDWebImageCache.self
        case .Nuke:
            return NukeCache.self
        }
    }
}

class ImageCacheProvider {
    private var cacheTypes = [ImageCacheFramework?: LazyImageCache]()
    
    init() {
        for value in ImageCacheFramework.allCases {
            cacheTypes[value] = LazyImageCache(value.getAssociatedCache())
        }
    }
    
    func createImageCache(for type: ImageCacheFramework?) -> ImageCache? {
        return cacheTypes[type]?.imageCache
    }
}
