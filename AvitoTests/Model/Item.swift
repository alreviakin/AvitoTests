//
//  Item.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 25.08.2023.
//

import Foundation

// MARK: - Items
struct Items: Codable {
    let items: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case items = "advertisements"
    }
}

// MARK: - Advertisement
struct Item: Codable {
    let id, title, price, location: String?
    let imageURL: String?
    let createdDate: String?

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}


