//
//  ScreenView.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import SVProgressHUD

protocol ScreenViewProtocol: ViewProtocol {
    
    /// Show HUD
    func showHUD()
    
    /// Hide HUD
    func dismissHUD()
    
    /// Show error
    ///
    /// - Parameter message: message
    func show(errorMessage: String?)
    
}

extension ScreenViewProtocol {
    
    func showHUD() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
    
    func dismissHUD() {
        SVProgressHUD.dismiss()
    }
    
    func show(errorMessage: String?) {
        SVProgressHUD.showError(withStatus: errorMessage)
    }
    
}
