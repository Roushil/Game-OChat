//
//  ChatLogPresenter.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/28/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol ChatLogPresenterInput {
    func presentMessage(response: ChatLog.Message.Save.Response)
    func presentChat(response: ChatLog.Message.Load.Response)
    func presentContactDetail(response: ChatLog.NewContact.Response)
}

protocol ChatLogPresenterOutput: class {
    func displayMessage(viewModel: ChatLog.Message.Save.ViewModel)
    func displayChat(viewModel: ChatLog.Message.Load.ViewModel)
    func displayContactDetail(viewModel: ChatLog.NewContact.ViewModel)
}

class ChatLogPresenter: ChatLogPresenterInput {
    
    weak var output: ChatLogPresenterOutput!
    
    // MARK: Presentation logic
    
    func presentMessage(response: ChatLog.Message.Save.Response) {
        
        let viewModel = ChatLog.Message.Save.ViewModel()
        output.displayMessage(viewModel: viewModel)
    }
    
    func presentContactDetail(response: ChatLog.NewContact.Response){
        
        output.displayContactDetail(viewModel: ChatLog.NewContact.ViewModel(viewContactDetail: response.contactDetail))
    }
    
    func presentChat(response: ChatLog.Message.Load.Response){
        
        output.displayChat(viewModel: ChatLog.Message.Load.ViewModel(message: response.message, chatPartner: response.chatPartner))
    }
}
