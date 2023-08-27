//
//  MainView.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 24.08.2023.
//

import UIKit

class MainView: UIView {
    weak var delegate: MainViewDelegate?
    
    private var indicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = delegate
        collection.delegate = delegate
        collection.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
    private var errorLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ошибка подключения к сети"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    

    func configure(isConnected: Bool) {
        backgroundColor = .white
        if isConnected {
            addSubview(collectionView)
            collectionView.isHidden = true
            addSubview(indicator)
            indicator.startAnimating()
        }else {
            addSubview(errorLabel)
        }
    }
    
    func presentAlert() {
        delegate?.presentView(getAlert())
        
    }
    
    func layout(isConnected: Bool) {
        if isConnected {
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
    }
}

extension MainView {
    private func getAlert() -> UIAlertController{
        let alert = UIAlertController(title: "Ошибка подключения к сети", message: "Попробовать обновить?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel)
        let reloadAction = UIAlertAction(title: "Обновить", style: .default)
        alert.addAction(cancelAction)
        alert.addAction(reloadAction)
        return alert
    }
}
