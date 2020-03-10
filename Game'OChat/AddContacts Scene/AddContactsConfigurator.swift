//
//  AddContactsConfigurator.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/15/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

extension AddContactsViewController: AddContactsPresenterOutput {}
extension AddContactsPresenter: AddContactsInteractorOutput {}
extension AddContactsInteractor: AddContactsViewControllerOutput {}

struct AddContactsConfigurator {
    
    // MARK: Configuration
    static func configure(viewController: AddContactsViewController) {
        
        let dataStore = DefaultAddContactsDataStore()
        let worker = AddContactsWorker()
        
        let router = AddContactsRouter()
        router.viewController = viewController
        router.dataStore = dataStore
        
        let presenter = AddContactsPresenter()
        presenter.output = viewController
        
        let interactor = AddContactsInteractor(dataStore: dataStore, worker: worker)
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
