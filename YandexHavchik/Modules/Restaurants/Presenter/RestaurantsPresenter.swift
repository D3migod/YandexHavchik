//
//  RestaurantsPresenter.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import Foundation

class RestaurantsPresenter: RestaurantsPresenterCore {
    private static let defaultCache: ImageCacheFramework = .Kingfisher
    
    private static let defaultImageSize = (width: 130, height: 100)
    
    private var interactor: RestaurantsInteractorInput!
    
    private weak var view: RestaurantsViewInput!
    
    private var imageCacheProvider: ImageCacheProvider!
    
    private var imageUriToUrlConverter: ImageUriToUrlConverter?
    
    private let initialImageCache: ImageCacheFramework!
    
    private let restaurantImageSize: (width: Int, height: Int)!
    
    init(interactor: RestaurantsInteractorInput,
         imageCacheProvider: ImageCacheProvider,
         imageUriToUrlConverter: ImageUriToUrlConverter?,
         initialImageCache: ImageCacheFramework = defaultCache,
         restaurantImageSize: (width: Int, height: Int) = defaultImageSize) {
        self.interactor = interactor
        self.imageCacheProvider = imageCacheProvider
        self.imageUriToUrlConverter = imageUriToUrlConverter
        self.initialImageCache = initialImageCache
        self.restaurantImageSize = restaurantImageSize
    }
    
    func setupView(view: RestaurantsViewInput) {
        self.view = view
        let titles: [ImageCacheFramework: String] = [
            .Kingfisher: "Kingfisher",
            .SDWebImage: "SDWebImage",
            .Nuke: "Nuke"
        ]
        view.setupImageCacheSegmentedControl(with: ImageCacheFramework.allCases.compactMap { titles[$0] }, defaultValueIndex: initialImageCache.rawValue)
        didChooseCacheRow(at: initialImageCache.rawValue)
    }
}

extension RestaurantsPresenter: RestaurantsViewOutputDelegate {
    func didChooseCacheRow(at index: Int) {
        view.imageCache = imageCacheProvider.createImageCache(for: ImageCacheFramework(rawValue: index))
    }
    
    func didLoadView() {
        interactor?.load(page: .initial)
    }
    
    func willLoadViewsAt(rowNumbers: [Int]) {
        // TODO: Handle repeated queries.
        guard let lastRowNumber = rowNumbers.last, lastRowNumber > view.restaurantsData.count else { return }
        interactor?.load(page: .next)
    }
}

extension RestaurantsPresenter: RestaurantsInteractorOutputDelegate {
    func didLoadRestaurants(_ restaurants: [Restaurant], for page: Page) {
        if page == .initial {
            view?.restaurantsData = restaurants.map(convertRestaurantToShowData)
        } else {
            view?.restaurantsData += restaurants.map(convertRestaurantToShowData)
        }
        view?.hideLoadingIndicator()
        view?.refreshData()
    }
    
    private func convertRestaurantToShowData(_ restaurant: Restaurant) -> RestaurantData {
        return RestaurantData(title: restaurant.name,
                  description: restaurant.description ?? "",
                  imageUrl: imageUriToUrlConverter?.convert(restaurant.picture?.uri, size: restaurantImageSize))
    }
    
    func didFailToLoadRestaurants(with error: Error, for page: Page) {
        print("ERROR: Failed to load restaurants for page \(page)")
        DispatchQueue.main.async {
            self.view?.showAlert(title: LocalizedConstantsMock.LoadErrorAlert.title,
                                 message: LocalizedConstantsMock.LoadErrorAlert.message + error.localizedDescription,
                                 okAction: { [weak self] _ in
                                    self?.interactor?.load(page: .initial)
            })
        }
        view?.hideLoadingIndicator()
    }
}
