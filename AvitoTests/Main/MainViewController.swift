//
//  MainViewController.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 24.08.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel?
    
    private var mainView = MainView()
    
    override func loadView() {
        super.loadView()
        view = mainView
        mainView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let isConnected = Reachability.isConnectedToNetwork()
        mainView.configure(isConnected: isConnected)
        mainView.layout(isConnected: isConnected)
        if !isConnected {
            DispatchQueue.main.async {
                let alert = AlertService().getNetworkErrorAlert { [weak self] in
                    guard let self else { return }
                    self.reload()
                }
                self.present(alert, animated: true)
                self.mainView.layout(isConnected: false)
            }
        } else {
            viewModel = MainViewModel()
            viewModel?.delegate = self
        }
    }
}

extension MainViewController: MainViewDelegate {    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewModel = viewModel?.getDetailViewModel(for: indexPath) else { return }
        let viewController = DetailViewController()
        viewController.viewModel = detailViewModel
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRow() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ItemCollectionViewCell, let viewModel else {
            return UICollectionViewCell()
        }
        let cellViewModel = viewModel.getItemCellViewModel(for: indexPath)
        cell.configure(with: cellViewModel)
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
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
    
    //MARK: - MainViewDelegate
    func reload() {
        let isConnected = Reachability.isConnectedToNetwork()
        mainView.configure(isConnected: isConnected)
        mainView.layout(isConnected: isConnected)
        if isConnected {
            viewModel = MainViewModel()
            viewModel?.delegate = self
        } else {
            let alert = AlertService().getNetworkErrorAlert { [weak self] in
                guard let self else { return }
                self.reload()
            }
            present(alert, animated: true)
        }
    }
    
}

extension MainViewController: MainViewControllerDelegate {
    func reloadData() {
        mainView.reloadData()
    }
}
