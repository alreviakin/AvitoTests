//
//  NetworkManager.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 25.08.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchMainItems(from stringURL: String, completion: @escaping ([Item]?)->()) {
        guard let url = URL(string: stringURL) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data, let items = try? JSONDecoder().decode(Items.self, from: data) else{
                completion(nil)
                return
            }
            completion(items.items)
        }.resume()
    }
    
    func fecthImage(from stringURL: String, completion: @escaping (Data?)->()) {
        guard let url = URL(string: stringURL) else {
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }
    
    func fetchDetailItem(from id: String, completion: @escaping (DetailItem?)->()) {
        guard let url = getDetailURL(from: id) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data, let detailItem = try? JSONDecoder().decode(DetailItem.self, from: data) else {
                completion(nil)
                return
            }
            completion(detailItem)
        }.resume()
    }
    
    private func getDetailURL(from id: String) -> URL? {
        let stringURL = "https://www.avito.st/s/interns-ios/details/\(id).json"
        let url = URL(string: stringURL)
        return url
    }
}
