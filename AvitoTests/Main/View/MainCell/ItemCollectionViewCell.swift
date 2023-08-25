//
//  ItemCollectionViewCell.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 24.08.2023.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    private var itemImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "1")
        return imageView
    }()
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Смартфон Apple iPhone 12"
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    private var priceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "55000 ₽"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    private var locationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Москва"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        return label
    }()
    private var dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2023-08-16"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(dateLabel)
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            locationLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -2),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            priceLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5),
        ])
    }
    
    override func prepareForReuse() {
        itemImageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        dateLabel.text = nil
    }
}
