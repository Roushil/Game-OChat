//
//  AddContactsInteractor.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/15/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

protocol AddContactsInteractorInput {
    func fetch(request: AddContacts.Fetch.Request)
}

protocol AddContactsInteractorOutput {
    func present(response: AddContacts.Fetch.Response)
}

class AddContactsInteractor: AddContactsInteractorInput {
    
    var output: AddContactsInteractorOutput!
    var dataStore: AddContactsDataStore!
    var worker: AddContactsWorker!
    
    init(dataStore: AddContactsDataStore, worker: AddContactsWorker) {
        self.dataStore = dataStore
        self.worker = worker
    }
    
    func fetch(request: AddContacts.Fetch.Request) {
        
        worker.fetch()
        worker.delegate = self
    }
}
extension AddContactsInteractor: PassContacts{

    func passData(contacts: [AddContactsModel]) {
        
        output.present(response: AddContacts.Fetch.Response(contactDataModel: contacts))
    }

}
