//
//  RestaurantsInteractor.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation

class RestaurantsInteractor: RestaurantsInteractorCore {
    
    private weak var outputDelegate: RestaurantsInteractorOutputDelegate?
    
    private var remoteDatamanager: RestaurantsRemoteDataManagerInput?
    
    private var coordinatesProvider: CoordinatesProvider?
    
    init(remoteDatamanager: RestaurantsRemoteDataManagerInput?) {
        self.remoteDatamanager = remoteDatamanager
    }
    
    func setup(with outputDelegate: RestaurantsInteractorOutputDelegate?,
               coordinatesProvider: CoordinatesProvider?) {
        self.outputDelegate = outputDelegate
        self.coordinatesProvider = coordinatesProvider
    }
}

extension RestaurantsInteractor: RestaurantsInteractorInput {
    
    func load(page: Page, callbackQueue: DispatchQueue) {
        // TODO: Check internet connection
        
        DispatchQueue.global().async {
            guard let coordinates = self.coordinatesProvider?.getCurrentCoordinates() else {
                self.outputDelegate?.didFailToLoadRestaurants(with: NetworkError.noConnection, for: page)
                return
            }
            self.remoteDatamanager?.getRestaurants(for: coordinates, resultHandler: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    callbackQueue.async {
                        self.outputDelegate?.didFailToLoadRestaurants(with: error, for: page)
                    }
                case .success(let restaurants):
                    callbackQueue.async {
                        self.outputDelegate?.didLoadRestaurants(restaurants, for: page)
                    }
                }
            })
        }
    }
}
