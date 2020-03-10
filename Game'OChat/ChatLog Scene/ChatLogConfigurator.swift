//
//  ChatLogConfigurator.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/28/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

extension ChatLogViewController: ChatLogPresenterOutput {}
extension ChatLogPresenter: ChatLogInteractorOutput {}
extension ChatLogInteractor: ChatLogViewControllerOutput {}

struct ChatLogConfigurator {
    
    // MARK: Configuration
    static func configure(viewController: ChatLogViewController) {
        
        let dataStore = DefaultChatLogDataStore()
        let worker = ChatLogWorker()
        
        let router = ChatLogRouter()
        router.viewController = viewController
        router.dataStore = dataStore
        
        let presenter = ChatLogPresenter()
        presenter.output = viewController
        
        let interactor = ChatLogInteractor(dataStore: dataStore, worker: worker)
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
