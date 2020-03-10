//
//  ContactsInteractor.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

protocol ContactsInteractorInput {
    func checkLogFetch(request: Contacts.Check.Request)
    func fetchLogout(request: Contacts.Logout.Request)
    func loadMessages(request: Contacts.Message.Request)
}

protocol ContactsInteractorOutput {
    
    func presentLogOut(response: Contacts.Logout.Response)
    func presentData(response: Contacts.Fetch.Response)
    func presentMessages(response: Contacts.Message.Response)
}

class ContactsInteractor: ContactsInteractorInput {
    
    var output: ContactsInteractorOutput!
    var dataStore: ContactsDataStore!
    var worker: ContactsWorker!
    
    init(dataStore: ContactsDataStore, worker: ContactsWorker) {
        self.dataStore = dataStore
        self.worker = worker
    }
    
    func checkLogFetch(request: Contacts.Check.Request) {
            
        worker.logDelegate = self
        worker.checkLogout()
    }
    
    func fetchLogout(request: Contacts.Logout.Request){
        
        worker.logDelegate = self
        worker.logOut()
    }
    
    func loadMessages(request: Contacts.Message.Request){
        
        worker.messageDelegate = self
        worker.loadUserMessages()
    }
}

extension ContactsInteractor: HandleLogout & Messages{


    func checkLog(isLogout: Bool, userData: [String : AnyObject?]) {
        
        if(isLogout == true){
            
            output.presentLogOut(response: Contacts.Logout.Response())
        }
        else{
            output.presentData(response: Contacts.Fetch.Response(userData: userData))
        }
    }
    
    func passMessage(messageModel: [MessageModel]) {
        
        output.presentMessages(response: Contacts.Message.Response(messageModel: messageModel))
        
    }
    
}

