//
//  LogInInteractor.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

protocol LogInInteractorInput {
    func fetch(request: LogIn.Fetch.Request)
}

protocol LogInInteractorOutput {
    func present(response: LogIn.Fetch.Response)
}

class LogInInteractor: LogInInteractorInput {
    
    var output: LogInInteractorOutput!
    var dataStore: LogInDataStore!
    var worker: LogInWorker!
    
    init(dataStore: LogInDataStore, worker: LogInWorker) {
        self.dataStore = dataStore
        self.worker = worker
    }
    
    func fetch(request: LogIn.Fetch.Request) {
        
        worker.logInUser(userData: request.userData, vc: request.viewController)
        output.present(response: LogIn.Fetch.Response())
    }
}
