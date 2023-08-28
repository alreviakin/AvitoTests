//
//  MainViewDelegate.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 24.08.2023.
//

import Foundation
import UIKit

protocol MainViewDelegate: AnyObject,
                           UICollectionViewDataSource,
                           UICollectionViewDelegate,
                           UICollectionViewDelegateFlowLayout{
    
    func reload()
}
