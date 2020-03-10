//
//  ChatLogInteractor.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/28/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

protocol ChatLogInteractorInput {
    func sendMessage(request: ChatLog.Message.Save.Request)
    func loadChat(request: ChatLog.Message.Load.Request)
    func addContactDetail(request: ChatLog.NewContact.Request)

}

protocol ChatLogInteractorOutput {
    func presentMessage(response: ChatLog.Message.Save.Response)
    func presentChat(response: ChatLog.Message.Load.Response)
    func presentContactDetail(response: ChatLog.NewContact.Response)

}

class ChatLogInteractor: ChatLogInteractorInput {
    
    var output: ChatLogInteractorOutput!
    var dataStore: ChatLogDataStore!
    var worker: ChatLogWorker!
    
    init(dataStore: ChatLogDataStore, worker: ChatLogWorker) {
        self.dataStore = dataStore
        self.worker = worker
    }
    
    func sendMessage(request: ChatLog.Message.Save.Request) {
        
        let response = ChatLog.Message.Save.Response()
        guard let userID = dataStore.selectedNewContact?.uniqueUserID else { return }
        worker.saveMessage(message: request.messgae, toUserID: userID)
        output.presentMessage(response: response)
    }
    
    func loadChat(request: ChatLog.Message.Load.Request){
        
        let userData = dataStore.selectedNewContact
        worker.delegate = self
        worker.loadMessages(userDetail: userData)
    }
    
    func addContactDetail(request: ChatLog.NewContact.Request){
        
        guard let contactDetail = dataStore.selectedNewContact else { return }
        output.presentContactDetail(response: ChatLog.NewContact.Response(contactDetail: contactDetail))
    }
}

extension ChatLogInteractor: LoadMessage{
    
    func passMessageDetails(message: [MessageModel], userDetail: AddContactsViewModel?) {
        
        output.presentChat(response: ChatLog.Message.Load.Response(message: message, chatPartner: userDetail))
    }
}
