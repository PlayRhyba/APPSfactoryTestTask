//
//  BaseNavigationController.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 18/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
}

// MARK: Private

private extension BaseNavigationController {
    
    func configureAppearance() {
        navigationBar.tintColor = UIColor(hex: 0x9A4B6F)
    }
    
}
