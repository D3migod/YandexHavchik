//
//  RestaurantsViewController.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import UIKit

protocol ImageCache {
    init()
    func loadImage(with absouluteUrl: String, into imageView: UIImageView, placeholder: UIImage)
    func clear()
    func cancelDownload(for imageView: UIImageView)
}

class RestaurantsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageCacheChoiceToolbar: UIToolbar! // TODO: Remove if not used
    
    @IBOutlet weak var imageCacheSegmentedControl: UISegmentedControl!
    
    private var outputDelegate: RestaurantsViewOutputDelegate!
    
    var imageCache: ImageCache?
    
    var restaurantsData: [RestaurantData]!
    
    func setup(with restaurantsData: [RestaurantData],
               outputDelegate: RestaurantsViewOutputDelegate) {
        self.restaurantsData = restaurantsData
        self.outputDelegate = outputDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupAppearance()
        outputDelegate.didLoadView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.prefetchDataSource = self
        tableView.tableFooterView = SpinnerView(style: .gray, width: tableView.bounds.width)
    }
    
    private func setupAppearance() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func cacheLibraryValueChanged(_ sender: Any) {
        outputDelegate?.didChooseCacheRow(at: imageCacheSegmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func clearCacheButtonTapped(_ sender: UIBarButtonItem) {
        imageCache?.clear()
    }
}

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < restaurantsData.count,
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantCell.self), for: indexPath) as? RestaurantCell else { return UITableViewCell() }
        let restaurantData = restaurantsData[indexPath.row]
        configureCell(cell, with: restaurantData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell:
        UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let restaurantImageView = (cell as? RestaurantCell)?.restaurantImageView else { return }
        imageCache?.cancelDownload(for: restaurantImageView)
    }
    
    private func configureCell(_ cell: RestaurantCell, with data: RestaurantData) {
        cell.titleLabel?.text = data.title
        cell.detailsLabel?.text = data.description
        if let imageUrl = data.imageUrl {
            imageCache?.loadImage(with: imageUrl, into: cell.restaurantImageView, placeholder: #imageLiteral(resourceName: "yandexLogo"))
        }
    }
}

extension RestaurantsViewController: RestaurantsViewInput {
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView?.isHidden = false
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView?.isHidden = true
        }
    }
    
    func refreshData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupImageCacheSegmentedControl(with titleArray: [String], defaultValueIndex: Int) {
        guard defaultValueIndex < titleArray.count else { return }
        DispatchQueue.main.async {
            self.imageCacheSegmentedControl.removeAllSegments()
            for (index, title) in titleArray.enumerated() {
                self.imageCacheSegmentedControl.insertSegment(withTitle: title, at: index, animated: false)
            }
            self.imageCacheSegmentedControl.selectedSegmentIndex = defaultValueIndex
        }
    }
}

extension RestaurantsViewController: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        outputDelegate.willLoadViewsAt(rowNumbers: indexPaths.map{$0.row})
    }
}
