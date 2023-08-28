//
//  MainViewModel.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 24.08.2023.
//

import Foundation

class MainViewModel {
    weak var delegate: MainViewControllerDelegate?
    
    //MARK: - Variables
    var items: [Item] = [] {
        didSet {
            fetchImages()
        }
    }
    var imagesData: [String : Data]? = [:] {
        didSet {
            delegate?.reloadData()
        }
    }
    
    init() {
        fetchData()
    }
    
    //MARK: - Collection
    func numberOfRow() -> Int {
        return items.count
    }
    
    func getItemCellViewModel(for indexPath: IndexPath) -> itemCellViewModel {
        
        let item = items[indexPath.row]
        let imageData = imagesData?[item.imageURL ?? ""] ?? Data()
        return itemCellViewModel(item: item, imageData: imageData)
    }
    
    func getDetailViewModel(for indexPath: IndexPath) -> DetailViewModel? {
        guard let id = items[indexPath.row].id else { return nil}
        return DetailViewModel(id: id)
    }
    
    //MARK: - Networking
    private func fetchImages() {
        var imagesData: [String: Data] = [:]
        let group = DispatchGroup()
        for item in items {
            if let imageURL = item.imageURL {
                group.enter()
                NetworkManager.shared.fecthImage(from: imageURL) { imageData in
                    imagesData[imageURL] = imageData
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            self.imagesData = imagesData
        }
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchMainItems(from: "https://www.avito.st/s/interns-ios/main-page.json") { items in
            guard let items else { return }
            self.items = items
        }
    }
    
    func reload() {
        fetchData()
    }
}
