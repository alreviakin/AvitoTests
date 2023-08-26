//
//  ItemCellViewModel.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 25.08.2023.
//

import Foundation

class itemCellViewModel {
    
    var imageURL: String
    var imageData: Data?
    var title: String
    var price: String
    var location: String
    var date: String
    
    init(item: Item, imageData: Data?) {
        self.imageURL = item.imageURL ?? ""
        self.title = item.title ?? ""
        self.price = item.price ?? ""
        self.location = item.location ?? ""
        self.date = item.createdDate ?? ""
        self.imageData = imageData
    }
    
    func fetchImageData(completion: @escaping (Data)->()) {
        NetworkManager.shared.fecthImage(from: imageURL) { imageData in
            completion(imageData)
        }
    }
}
