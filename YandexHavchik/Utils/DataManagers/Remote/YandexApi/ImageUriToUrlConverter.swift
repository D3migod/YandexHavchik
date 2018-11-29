//
//  UriToUrlConverter.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 30/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation

class ImageUriToUrlConverter {
    func convert(_ uri: String?, size: (width: Int, height: Int)) -> String? {
        guard var pictureUri = uri else { return nil }
        // Not scalable yet fastest way to convert
        pictureUri.replaceSubrange(pictureUri.index(pictureUri.endIndex, offsetBy: -11)...pictureUri.index(pictureUri.endIndex, offsetBy: -9), with: "\(size.width)")
        
        pictureUri.replaceSubrange(pictureUri.index(pictureUri.endIndex, offsetBy: -7)...pictureUri.index(pictureUri.endIndex, offsetBy: -5), with: "\(size.height)")
        return "https://eda.yandex\(pictureUri)"
    }
}
