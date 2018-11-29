//
//  SpinnerView.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import UIKit

class SpinnerView: UIActivityIndicatorView {
    private static let defaultSideSize: CGFloat = 44
    
    init(style: UIActivityIndicatorView.Style, x: CGFloat = 0, y: CGFloat = 0, width: CGFloat = defaultSideSize, height: CGFloat = defaultSideSize) {
        super.init(style: style)
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        startAnimating()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
