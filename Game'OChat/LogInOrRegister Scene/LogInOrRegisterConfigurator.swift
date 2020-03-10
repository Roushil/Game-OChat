//
//  LogInOrRegisterConfigurator.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

extension LogInOrRegisterViewController: LogInOrRegisterPresenterOutput {}
extension LogInOrRegisterPresenter: LogInOrRegisterInteractorOutput {}
extension LogInOrRegisterInteractor: LogInOrRegisterViewControllerOutput {}

struct LogInOrRegisterConfigurator {
    
    // MARK: Configuration
    static func configure(viewController: LogInOrRegisterViewController) {
        
        let dataStore = DefaultLogInOrRegisterDataStore()
        let worker = LogInOrRegisterWorker()
        
        let router = LogInOrRegisterRouter()
        router.viewController = viewController
        router.dataStore = dataStore
        
        let presenter = LogInOrRegisterPresenter()
        presenter.output = viewController
        
        let interactor = LogInOrRegisterInteractor(dataStore: dataStore, worker: worker)
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
