//
//  NukeCache.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 28/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation
import Nuke

final class NukeCache: ImageCache {
    func clear() {
        Nuke.ImageCache.shared.removeAll()
    }
    
    func loadImage(with absouluteUrl: String, into imageView: UIImageView, placeholder: UIImage) {
        guard let url = URL(string: absouluteUrl) else { return }
        Nuke.loadImage(with: url, options: ImageLoadingOptions(placeholder: placeholder), into: imageView)
    }
    
    func cancelDownload(for imageView: UIImageView) {
        Nuke.cancelRequest(for: imageView)
    }
}
