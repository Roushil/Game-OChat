//
//  LogInConfigurator.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

extension LogInViewController: LogInPresenterOutput {}
extension LogInPresenter: LogInInteractorOutput {}
extension LogInInteractor: LogInViewControllerOutput {}

struct LogInConfigurator {
    
    // MARK: Configuration
    static func configure(viewController: LogInViewController) {
        
        let dataStore = DefaultLogInDataStore()
        let worker = LogInWorker()
        
        let router = LogInRouter()
        router.viewController = viewController
        router.dataStore = dataStore
        
        let presenter = LogInPresenter()
        presenter.output = viewController
        
        let interactor = LogInInteractor(dataStore: dataStore, worker: worker)
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
