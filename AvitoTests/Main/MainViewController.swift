//
//  MainViewController.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 24.08.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel = MainViewModel()
    
    private var mainView = MainView()
    
    override func loadView() {
        super.loadView()
        view = mainView
        viewModel.delegate = self
        mainView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let isConnected = Reachability.isConnectedToNetwork()
        mainView.configure(isConnected: isConnected)
        mainView.layout(isConnected: isConnected)
        if !isConnected {
            DispatchQueue.main.async {
                self.mainView.presentAlert()
                self.mainView.layout(isConnected: false)
            }
        }
    }
}

extension MainViewController: MainViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellViewModel = viewModel.getItemCellViewModel(for: indexPath)
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.width - 42) / 2, height: view.bounds.height / 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func presentView(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
}

extension MainViewController: MainViewControllerDelegate {
    func reloadData() {
        mainView.reloadData()
    }
}
