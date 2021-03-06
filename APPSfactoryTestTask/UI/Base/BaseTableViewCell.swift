//
//  BaseTableViewCell.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, ViewProtocol {
    
    var presenter: PresenterProtocol? {
        didSet {
            if let presenter = presenter {
                presenter.attachView(self)
            } else {
                presenter?.detachView()
            }
        }
    }
    
    // MARK: Deinitialization
    
    deinit {
        presenter?.detachView()
        presenter?.deinitialization()
    }
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        presenter = nil
    }
    
}
