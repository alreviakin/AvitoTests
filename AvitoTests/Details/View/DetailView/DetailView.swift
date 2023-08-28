//
//  DetailView.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 27.08.2023.
//

import UIKit

class DetailView: UIView {
    weak var delegate: DetailViewDelegate?
    
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
    private var errorLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ошибка подключения к сети"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    private var indicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    private lazy var backButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    private var itemImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private var priceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    private var locationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private var dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private var descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private var emailLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private var phoneLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private var addressLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(isConnected: Bool, isFirstConfigure: Bool) {
        backgroundColor = .white
        if isFirstConfigure {
            addSubview(backButton)
        }
        if isConnected {
            errorLabel.isHidden = true
            reloadButton.isHidden = true
            addSubview(itemImageView)
            addSubview(titleLabel)
            addSubview(priceLabel)
            addSubview(locationLabel)
            addSubview(dateLabel)
            addSubview(descriptionLabel)
            addSubview(emailLabel)
            addSubview(phoneLabel)
            addSubview(addressLabel)
            addSubview(indicator)
            indicator.startAnimating()
        }else {
            indicator.stopAnimating()
            indicator.isHidden = true
            errorLabel.isHidden = false
            reloadButton.isHidden = false
            addSubview(reloadButton)
            addSubview(errorLabel)
        }
    }
    
    func layout(isConnected: Bool, isFirstLayout: Bool) {
        if isFirstLayout {
            NSLayoutConstraint.activate([
                backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                backButton.widthAnchor.constraint(equalToConstant: 24),
                backButton.heightAnchor.constraint(equalToConstant: 24),
            ])
        }
        if isConnected {
            NSLayoutConstraint.activate([
                itemImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
                itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                itemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                itemImageView.heightAnchor.constraint(equalToConstant: bounds.height * 0.3),
                
                titleLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                titleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 10),
                
                priceLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
                priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
                
                locationLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
                locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
                
                addressLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
                addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                addressLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 0),
                
                emailLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
                emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                emailLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
                
                phoneLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
                phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 0),
                
                descriptionLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                descriptionLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
                
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
    
    func configure(with detailItem: DetailItem, imageData: Data) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.titleLabel.text = detailItem.title
            self.priceLabel.text = detailItem.price
            self.locationLabel.text = detailItem.location
            self.addressLabel.text = detailItem.address
            self.emailLabel.text = detailItem.email
            self.phoneLabel.text = detailItem.phoneNumber
            self.descriptionLabel.text = detailItem.description
            self.itemImageView.image = UIImage(data: imageData)
        }
    }
    
    @objc private func back() {
        delegate?.back()
    }
    
    @objc private func reload() {
        delegate?.reload()
    }
}


