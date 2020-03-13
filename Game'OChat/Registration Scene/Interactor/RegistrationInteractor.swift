//
//  RegistrationInteractor.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

protocol RegistrationInteractorInput {
    func fetch(request: Registration.Fetch.Request)
}

protocol RegistrationInteractorOutput {
    func presentAlertError(response: Registration.AlertMessage.Error.Response)
    func presentAlertSuccess(response: Registration.AlertMessage.Success.Response)
}

class RegistrationInteractor: RegistrationInteractorInput {
    
    var output: RegistrationInteractorOutput!
    var dataStore: RegistrationDataStore!
    var worker: RegistrationWorker!
    
    init(dataStore: RegistrationDataStore, worker: RegistrationWorker) {
        self.dataStore = dataStore
        self.worker = worker
    }
    
    func fetch(request: Registration.Fetch.Request) {
        
        worker.errorAlertDelegate = self
        worker.successAlertDelegate = self
        worker.registerUserData(registerData: request.registerData, vc: request.viewcontroller)
    }
}

extension RegistrationInteractor: ErrorAlert & SuccessAlert{

    func alertError(message: String) {
        
        output.presentAlertError(response: Registration.AlertMessage.Error.Response(message: message))
    }
    
    func alertSuccess(message: String) {
        
        output.presentAlertSuccess(response: Registration.AlertMessage.Success.Response(message: message))
    }
    
    
}
