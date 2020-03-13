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
    func presentErrorAlert(response: LogIn.AlertMessage.Error.Response)
    func presentSuccessAlert(response: LogIn.AlertMessage.Success.Response)
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
        
        worker.alertErrorDelegate = self
        worker.alertSuccessDelegate = self
        worker.logInUser(userData: request.userData, vc: request.viewController)
    }
}

extension LogInInteractor: ErrorAlert & SuccessAlert{

    
    func alertError(message: String) {
        
        output.presentErrorAlert(response: LogIn.AlertMessage.Error.Response(message: message))
    }
    
    func alertSuccess(message: String) {
        
        output.presentSuccessAlert(response: LogIn.AlertMessage.Success.Response(message: message))
    }
}
