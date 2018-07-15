//
//  DetailsViewController.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

final class DetailsViewController: BaseViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
}

// MARK: DetailsViewProtocol

extension DetailsViewController: DetailsViewProtocol {
    
}

// MARK: Private

private extension DetailsViewController {
    
    func getPresenter() -> DetailsPresenterProtocol? {
        return presenter as? DetailsPresenterProtocol
    }
    
    func configureAppearance() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_dark")!)
    }
    
}
