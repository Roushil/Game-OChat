//
//  RegistrationConfigurator.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

extension RegistrationViewController: RegistrationPresenterOutput {}
extension RegistrationPresenter: RegistrationInteractorOutput {}
extension RegistrationInteractor: RegistrationViewControllerOutput {}

struct RegistrationConfigurator {
    
    // MARK: Configuration
    static func configure(viewController: RegistrationViewController) {
        
        let dataStore = DefaultRegistrationDataStore()
        let worker = RegistrationWorker()
        
        let router = RegistrationRouter()
        router.viewController = viewController
        router.dataStore = dataStore
        
        let presenter = RegistrationPresenter()
        presenter.output = viewController
        
        let interactor = RegistrationInteractor(dataStore: dataStore, worker: worker)
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
