//
//  ScreenPresenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

protocol ScreenPresenterProtocol: PresenterProtocol {
    
    /// Lifecycle method
    func viewDidLoad()
    
    /// Lifecycle method
    func viewWillAppear()
    
    /// Lifecycle method
    func viewDidAppear()
    
    /// Lifecycle method
    func viewWillDisappear()
    
    /// Lifecycle method
    func viewDidDisappear()
    
}

class ScreenPresenter: Presenter, ScreenPresenterProtocol {
    
    // MARK: ScreenPresenterProtocol
    
    func viewDidLoad() {}
    
    func viewWillAppear() {}
    
    func viewDidAppear() {}
    
    func viewWillDisappear() {}
    
    func viewDidDisappear() {}
    
}
