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
    private lazy var reloadButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Обновить", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(reload), for: .touchUpInside)
        return button
    }()

    func configure(isConnected: Bool) {
        backgroundColor = .white
        if isConnected {
            self.errorLabel.isHidden = true
            self.reloadButton.isHidden = true
            addSubview(collectionView)
            collectionView.isHidden = true
            addSubview(indicator)
            indicator.startAnimating()
        }else {
            addSubview(errorLabel)
            addSubview(reloadButton)
        }
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
            guard let reloadTitleLabel = reloadButton.titleLabel else { return }
            NSLayoutConstraint.activate([
                errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                
                reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                reloadButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 10),
                
                reloadTitleLabel.leadingAnchor.constraint(equalTo: reloadButton.leadingAnchor, constant: 10),
                reloadTitleLabel.trailingAnchor.constraint(equalTo: reloadButton.trailingAnchor, constant: -10),
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
    
    @objc private func reload() {
        delegate?.reload()
    }
}
