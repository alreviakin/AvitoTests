//
//  MainViewModel.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 24.08.2023.
//

import Foundation

class MainViewModel {
    weak var delegate: MainViewControllerDelegate?
    
    var items: [Item] = [] {
        didSet {
            delegate?.reloadData()
            print("reload")
        }
    }
    var imagesData: [String : Data] = [:]
    
    init() {
        fetchData()
    }
    
    func numberOfRow() -> Int {
        return items.count
    }
    
    func getItemCellViewModel(for indexPath: IndexPath) -> itemCellViewModel {
        
        let item = items[indexPath.row]
        if let imageData = imagesData[item.imageURL ?? ""] {
            return itemCellViewModel(item: item, imageData: imageData)
        } else {
            if let imageURL = item.imageURL {
                NetworkManager.shared.fecthImage(from: imageURL) {[weak self] imageData in
                    guard let self else { return }
                    self.imagesData[imageURL] = imageData
                }
            }
            return itemCellViewModel(item: item, imageData: nil)
        }
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchMainItems(from: "https://www.avito.st/s/interns-ios/main-page.json") { items in
            guard let items else { return }
            self.items = items
        }
    }
}
