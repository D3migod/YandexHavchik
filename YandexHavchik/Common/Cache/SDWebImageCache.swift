//
//  SDWebImage.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 28/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation
import SDWebImage

final class SDWebImageCache: ImageCache {
    func clear() {
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }
    
    func loadImage(with absouluteUrl: String, into imageView: UIImageView, placeholder: UIImage) {
        imageView.sd_setImage(with: URL(string: absouluteUrl), placeholderImage: placeholder)
    }
    
    func cancelDownload(for imageView: UIImageView) {
        imageView.sd_cancelCurrentImageLoad()
    }
}
