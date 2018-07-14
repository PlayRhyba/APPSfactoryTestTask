//
//  Presenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import os.log

protocol PresenterProtocol: class {
    
    /// Initialization
    func initialization()
    
    /// Deinitialization
    func deinitialization()
    
    ///  Attach view to presenter
    ///
    ///  - parameter view: view
    func attachView(_ view: ViewProtocol)
    
    ///  View has been attached
    func onViewAttached()
    
    /// Detach view
    func detachView()
    
    ///  View has been detached
    func onViewDetached()
    
}

// MARK: Default implementations

extension PresenterProtocol {
    
    func initialization() {}
    
    func deinitialization() {}
    
    func attachView(_ view: ViewProtocol) {}
    
    func onViewAttached() {}
    
    func detachView() {}
    
    func onViewDetached() {}
    
}

class Presenter: PresenterProtocol {
    
    weak var view: ViewProtocol?
    
    // MARK: PresenterProtocol
    
    func initialization() {
        os_log("PRESENTER ATTACHED (%@)", "\(type(of: self))")
    }
    
    func deinitialization() {
        os_log("PRESENTER DETACHED (%@)", "\(type(of: self))")
    }
    
    func attachView(_ view: ViewProtocol) {
        self.view = view
        onViewAttached()
    }
    
    func onViewAttached() {}
    
    func detachView() {
        view = nil
        onViewDetached()
    }
    
    func onViewDetached() {}
    
}
