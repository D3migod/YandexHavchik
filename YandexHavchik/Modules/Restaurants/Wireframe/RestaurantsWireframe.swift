//
//  RestaurantsWireframe.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import UIKit

class RestaurantsWireframe: RestaurantsWireframeInput {
    private static let mainStoryboardIdentifier = "Main"
    
    class func createConnections() -> UIViewController {
        let dataManagerFactory = YandexRemoteDataManagerFactory()
        let remoteDataManager: RestaurantsRemoteDataManagerInput = dataManagerFactory.createRestaurantsDataManager()
        
        let interactor: RestaurantsInteractorInput & RestaurantsInteractorCore = RestaurantsInteractor(remoteDatamanager: remoteDataManager)
        
        let presenter: RestaurantsViewOutputDelegate &
            RestaurantsPresenterCore &
            RestaurantsInteractorOutputDelegate = RestaurantsPresenter(interactor: interactor, imageCacheProvider: ImageCacheProvider(), imageUriToUrlConverter: ImageUriToUrlConverter())
        interactor.setup(with: presenter, coordinatesProvider: Locator())
        let storyboard = UIStoryboard(name: RestaurantsWireframe.mainStoryboardIdentifier, bundle: nil)
        
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: RestaurantsViewController.self)) as? RestaurantsViewController else { return UIViewController() }
        controller.setup(with: [], outputDelegate: presenter)
        presenter.setupView(view: controller)
        
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }
}
