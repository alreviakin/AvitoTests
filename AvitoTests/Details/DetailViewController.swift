//
//  DetailViewController.swift
//  AvitoTests
//
//  Created by Алексей Ревякин on 27.08.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var detailView = DetailView()
    var viewModel: DetailViewModel?
    
    override func loadView() {
        super.loadView()
        view = detailView
        viewModel?.delegate = self
        detailView.delegate = self
        let isConnected = Reachability.isConnectedToNetwork()
        detailView.configure(isConnected: isConnected, isFirstConfigure: true)
        if !isConnected {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                let alert = AlertService().getNetworkErrorAlert { [weak self] in
                    guard let self else { return }
                    self.reload()
                }
                present(alert, animated: true)
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let isConnected = Reachability.isConnectedToNetwork()
        detailView.layout(isConnected: isConnected, isFirstLayout: true)
    }
}

extension DetailViewController: DetailViewControllerDelegate {
    func loadingErrorImageAlert() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.detailView.configure(isConnected: false, isFirstConfigure: false)
            self.detailView.layout(isConnected: false, isFirstLayout: false)
            let alert = AlertService().getLoadingErrorImage {
                self.reload()
            }
            self.present(alert, animated: true)
        }
    }
    
    func updateUI(detailItem: DetailItem, imageData: Data) {
        detailView.configure(with: detailItem, imageData: imageData)
    }
}

extension DetailViewController: DetailViewDelegate {
    func back() {
        dismiss(animated: true)
    }
    
    func reload() {
        let isConnected = Reachability.isConnectedToNetwork()
        detailView.configure(isConnected: isConnected, isFirstConfigure: false)
        detailView.layout(isConnected: isConnected, isFirstLayout: false)
        if isConnected {
            viewModel?.reload()
        } else {
            let alert = AlertService().getNetworkErrorAlert { [weak self] in
                guard let self else { return }
                self.reload()
            }
            present(alert, animated: true)
        }
    }
}
