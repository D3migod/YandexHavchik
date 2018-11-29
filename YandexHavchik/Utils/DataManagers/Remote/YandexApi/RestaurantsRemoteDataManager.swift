//
//  RestaurantsRemoteDataManager.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation

private enum ParameterNames: String {
    case latitude
    case longitude
}

class RestaurantsRemoteDataManager {
    private static let path = "catalog"
    private let remoteDataManager: RemoteDataManager<RestaurantSearch>
    
    init(remoteDataManager: RemoteDataManager<RestaurantSearch>) {
        self.remoteDataManager = remoteDataManager
    }
}

extension RestaurantsRemoteDataManager: RestaurantsRemoteDataManagerInput {
    func getRestaurants(for coordinates: Coordinates, resultHandler: ((Result<[Restaurant]>) -> Void)?) {
        let parameters = [ParameterNames.latitude.rawValue: String(coordinates.latitude),
                          ParameterNames.longitude.rawValue: String(coordinates.longitude)]
        remoteDataManager.getEntity(RestaurantsRemoteDataManager.path, parameters: parameters) { result in
            switch result {
            case .failure(let error):
                resultHandler?(Result.failure(error))
            case .success(let restautantSearch):
                resultHandler?(Result.success(restautantSearch.restaurants))
            }
        }
    }
}
