//
//  MainView.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 24.08.2023.
//

import UIKit

class MainView: UIView {
    weak var delegate: MainViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = delegate
        collection.delegate = delegate
        collection.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
    

    func configure() {
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
