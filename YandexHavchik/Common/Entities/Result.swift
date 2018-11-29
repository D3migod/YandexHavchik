//
//  Result.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}
