//
//  ContactsConfigurator.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

extension ContactsViewController: ContactsPresenterOutput {}
extension ContactsPresenter: ContactsInteractorOutput {}
extension ContactsInteractor: ContactsViewControllerOutput {}

struct ContactsConfigurator {
    
    // MARK: Configuration
    static func configure(viewController: ContactsViewController) {
        
        let dataStore = DefaultContactsDataStore()
        let worker = ContactsWorker()
        
        let router = ContactsRouter()
        router.viewController = viewController
        router.dataStore = dataStore
        
        let presenter = ContactsPresenter()
        presenter.output = viewController
        
        let interactor = ContactsInteractor(dataStore: dataStore, worker: worker)
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
