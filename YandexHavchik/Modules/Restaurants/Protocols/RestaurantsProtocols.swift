//
//  RestaurantsProtocols.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import UIKit

protocol RestaurantsWireframeInput {
    static func createConnections() -> UIViewController
}

protocol RestaurantsInteractorCore {
    func setup(with outputDelegate: RestaurantsInteractorOutputDelegate?,
               coordinatesProvider: CoordinatesProvider?)
}

protocol RestaurantsInteractorOutputDelegate: class {
    func didFailToLoadRestaurants(with: Error, for page: Page)
    func didLoadRestaurants(_ restaurants: [Restaurant], for page: Page)
}

protocol RestaurantsRemoteDataManagerInput {
    func getRestaurants(for coordinates: Coordinates, resultHandler: ((Result<[Restaurant]>)-> Void)?)
}

protocol RestaurantsViewInput: class {
    var restaurantsData: [RestaurantData]! { get set }
    
    var imageCache: ImageCache? { get set }
    
    func showLoadingIndicator()
    
    func hideLoadingIndicator()
    
    func refreshData()
    
    func showAlert(title: String?, message: String?, okAction: ((UIAlertAction) -> Void)?)
    
    func setupImageCacheSegmentedControl(with titleArray: [String], defaultValueIndex: Int)
}

protocol RestaurantsViewOutputDelegate {
    func didLoadView()
    
    func willLoadViewsAt(rowNumbers: [Int])
    
    func didChooseCacheRow(at index: Int)
}

protocol RestaurantsPresenterCore {
    func setupView(view: RestaurantsViewInput)
}

protocol RestaurantsInteractorInput {
    func load(page: Page, callbackQueue: DispatchQueue)
}

extension RestaurantsInteractorInput {
    func load(page: Page, callbackQueue: DispatchQueue = DispatchQueue.main) {
        load(page: page, callbackQueue: callbackQueue)
    }
}
