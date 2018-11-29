//
//  YandexRemoteDataManagerFactory.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation

class YandexRemoteDataManagerFactory {
    private let apiEndpoint: String!
    private let networkRouter: NetworkRouter!
    
    init() {
        apiEndpoint = "https://eda.yandex/api/v2"
        networkRouter = NetworkRouter()
    }
    
    func createRestaurantsDataManager() -> RestaurantsRemoteDataManager {
        let remoteDataManager = RemoteDataManager<RestaurantSearch>(apiEndpoint, networkRouter: networkRouter)
        return RestaurantsRemoteDataManager(remoteDataManager: remoteDataManager)
    }
}
