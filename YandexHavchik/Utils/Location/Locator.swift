//
//  Locator.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 28/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation

typealias Coordinates = (latitude: Double, longitude: Double)

protocol CoordinatesProvider {
    func getCurrentCoordinates() -> Coordinates
}
class Locator {}

extension Locator: CoordinatesProvider {
    func getCurrentCoordinates() -> Coordinates {
        return (55.762885, 37.597360)
    }
}
