//
//  LogInOrRegisterInteractor.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

protocol LogInOrRegisterInteractorInput {
    func fetch(request: LogInOrRegister.Fetch.Request)

}

protocol LogInOrRegisterInteractorOutput {
    func present(response: LogInOrRegister.Fetch.Response)

}

class LogInOrRegisterInteractor: LogInOrRegisterInteractorInput {
    
    var output: LogInOrRegisterInteractorOutput!
    var dataStore: LogInOrRegisterDataStore!
    var worker: LogInOrRegisterWorker!
    
    init(dataStore: LogInOrRegisterDataStore, worker: LogInOrRegisterWorker) {
        self.dataStore = dataStore
        self.worker = worker
    }
    
    func fetch(request: LogInOrRegister.Fetch.Request) {
        
        let response = LogInOrRegister.Fetch.Response()
        output.present(response: response)
    }
    

}
