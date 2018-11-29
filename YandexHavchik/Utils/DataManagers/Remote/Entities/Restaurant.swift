//
//  Restaurant.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation

struct Restaurant: Decodable {
    var name: String
    var description: String?
    var picture: Picture?
    
    enum CodingKeys: String, CodingKey {
        case name
        case description = "footerDescription"
        case picture
        case place
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .place)
        name = try response.decode(String.self, forKey: .name)
        description = try? response.decode(String.self, forKey: .description)
        picture = try? response.decode(Picture.self, forKey: .picture)
    }
}

struct Picture: Decodable {
    var uri: String
    var ratio: Double
}
