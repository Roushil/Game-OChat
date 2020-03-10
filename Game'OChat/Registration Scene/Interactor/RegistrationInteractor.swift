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
    func present(response: Registration.Fetch.Response)
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
        
        let data = request.registerData
        let vc = request.viewcontroller
        worker.registerUserData(registerData: data, vc: vc)
        output.present(response: Registration.Fetch.Response())
    }
}
