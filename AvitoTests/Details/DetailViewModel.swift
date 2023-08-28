//
//  DetailViewModel.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 27.08.2023.
//

import Foundation

class DetailViewModel {
    weak var delegate: DetailViewControllerDelegate?
    private var detailItem: DetailItem? {
        didSet {
            fetchImageData()
        }
    }
    private var imageData: Data? {
        didSet {
            guard let detailItem, let imageData else {
                delegate?.loadingErrorImageAlert()
                return
            }
            delegate?.updateUI(detailItem: detailItem, imageData: imageData)
        }
    }
    private var id: String
    
    
    init(id: String) {
        self.id = id
        fetchDetailItem(from: id)
    }
    
    private func fetchDetailItem(from id: String) {
        NetworkManager.shared.fetchDetailItem(from: id) { [weak self] detailItem in
            guard let self, let detailItem else { return }
            self.detailItem = detailItem
        }
    }
    
    private func fetchImageData() {
        guard let detailItem, let imageURL = detailItem.imageURL else { return }
        NetworkManager.shared.fecthImage(from: imageURL) { [weak self] imageData in
            guard let self else { return }
            self.imageData = imageData
        }
    }
    
    func reload() {
        fetchDetailItem(from: id)
    }
}
