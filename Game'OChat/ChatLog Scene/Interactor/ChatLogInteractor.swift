//
//  ChatLogInteractor.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/28/20.
//  Copyright (c) 2020 personal. All rights reserved.


import UIKit

protocol ChatLogInteractorInput {
    func sendMessage(request: ChatLog.Message.SaveText.Request)
    func sendImage(request: ChatLog.Message.SaveImage.Request)
    func loadChat(request: ChatLog.Message.Load.Request)
    func addContactDetail(request: ChatLog.NewContact.Request)
    
}

protocol ChatLogInteractorOutput {
    
    func presentChat(response: ChatLog.Message.Load.Response)
    func presentContactDetail(response: ChatLog.NewContact.Response)
    func presentAlert(response: ChatLog.AlertMessage.Response)
}

class ChatLogInteractor: ChatLogInteractorInput {
    
    var output: ChatLogInteractorOutput!
    var dataStore: ChatLogDataStore!
    var worker: ChatLogWorker!
    
    init(dataStore: ChatLogDataStore, worker: ChatLogWorker) {
        self.dataStore = dataStore
        self.worker = worker
    }
    
    func sendMessage(request: ChatLog.Message.SaveText.Request) {
        
        guard let userID = dataStore.selectedNewContact?.uniqueUserID else { return }
        worker.alertDelegate = self
        worker.saveMessage(textMessage: request.messgae, toUserID: userID)
    }
    
    func sendImage(request: ChatLog.Message.SaveImage.Request){
        
        guard let userID = dataStore.selectedNewContact?.uniqueUserID else { return }
        worker.alertDelegate = self
        worker.saveImage(image: request.image, toUserID: userID)
    }
    
    func loadChat(request: ChatLog.Message.Load.Request){
        
        let userData = dataStore.selectedNewContact
        worker.alertDelegate = self
        worker.delegate = self
        worker.loadMessages(userDetail: userData)
    }
    
    func addContactDetail(request: ChatLog.NewContact.Request){
        
        guard let contactDetail = dataStore.selectedNewContact else { return }
        output.presentContactDetail(response: ChatLog.NewContact.Response(contactDetail: contactDetail))
    }
}

extension ChatLogInteractor: LoadMessage & ErrorAlert{

    func passMessageDetails(message: [MessageModel], userDetail: AddContactsModel?) {
        
        output.presentChat(response: ChatLog.Message.Load.Response(message: message, chatPartner: userDetail))
    }
    
    func alertError(message: String) {
        
        output.presentAlert(response: ChatLog.AlertMessage.Response(message: message))
    }
    
    
}
