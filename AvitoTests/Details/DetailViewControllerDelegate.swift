//
//  DetailViewControllerDelegate.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 28.08.2023.
//

import Foundation

protocol DetailViewControllerDelegate: AnyObject {
    func updateUI(detailItem: DetailItem, imageData: Data)
    func loadingErrorImageAlert()
}
