//
//  RestaurantSearch.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation
struct RestaurantSearch: Decodable {
    var restaurants: [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case payload
        case restaurants = "foundPlaces"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .payload)
        restaurants = try response.decode([Restaurant].self, forKey: .restaurants)
    }
}
