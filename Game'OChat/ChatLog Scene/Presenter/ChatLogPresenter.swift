//
//  ChatLogPresenter.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/28/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol ChatLogPresenterInput {
    func presentChat(response: ChatLog.Message.Load.Response)
    func presentContactDetail(response: ChatLog.NewContact.Response)
    func presentAlert(response: ChatLog.AlertMessage.Response)
}

protocol ChatLogPresenterOutput: class {
    func displayChat(viewModel: ChatLog.Message.Load.ViewModel)
    func displayContactDetail(viewModel: ChatLog.NewContact.ViewModel)
    func displayAlert(viewModel: ChatLog.AlertMessage.ViewModel)
}

class ChatLogPresenter: ChatLogPresenterInput {
    
    weak var output: ChatLogPresenterOutput!
    
    // MARK: Presentation logic
    
    func presentContactDetail(response: ChatLog.NewContact.Response){
        
        output.displayContactDetail(viewModel: ChatLog.NewContact.ViewModel(viewContactDetail: response.contactDetail))
    }
    
    func presentChat(response: ChatLog.Message.Load.Response){
        
        output.displayChat(viewModel: ChatLog.Message.Load.ViewModel(message: response.message, chatPartner: response.chatPartner))
    }
    
    func presentAlert(response: ChatLog.AlertMessage.Response){
        
        output.displayAlert(viewModel: ChatLog.AlertMessage.ViewModel(message: response.message))
    }
    
}
