//
//  AlertService.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 28.08.2023.
//

import Foundation
import UIKit

class AlertService {
    func getNetworkErrorAlert(action: @escaping ()->()) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка подключения к сети", message: "Попробовать обновить?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel)
        let reloadAction = UIAlertAction(title: "Обновить", style: .default) { _ in
            action()
        }
        alert.addAction(cancelAction)
        alert.addAction(reloadAction)
        return alert
    }
    
    func getLoadingErrorImage(action: @escaping ()->()) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка при загрузке фотографии", message: "Попробовать обновить?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel)
        let reloadAction = UIAlertAction(title: "Обновить", style: .default) { _ in
            action()
        }
        alert.addAction(cancelAction)
        alert.addAction(reloadAction)
        return alert
    }
}
