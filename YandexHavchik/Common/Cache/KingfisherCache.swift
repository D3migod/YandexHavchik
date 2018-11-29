//
//  KingfisherCache.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 28/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation
import Kingfisher

final class KingfisherCache: ImageCache {
    func clear() {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
    }
    
    func loadImage(with absouluteUrl: String, into imageView: UIImageView, placeholder: UIImage) {
        imageView.kf.setImage(with: URL(string: absouluteUrl), placeholder: placeholder)
    }
    
    func cancelDownload(for imageView: UIImageView) {
        imageView.kf.cancelDownloadTask()
    }
}
