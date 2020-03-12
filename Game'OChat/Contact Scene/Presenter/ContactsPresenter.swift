//
//  ContactsPresenter.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol ContactsPresenterInput {
    func presentLogOut(response: Contacts.Logout.Response)
    func presentData(response: Contacts.Fetch.Response)
    func presentMessages(response: Contacts.Message.Response)
    func presentDeletedMessage(response: Contacts.Delete.Response)
}

protocol ContactsPresenterOutput: class {
    func displayLogOut(viewModel: Contacts.Logout.ViewModel)
    func displayData(viewModel: Contacts.Fetch.ViewModel)
    func displayMessages(viewModel: Contacts.Message.ViewModel)
    func displayDeletedMessage(viewModel: Contacts.Delete.ViewModel)
}

class ContactsPresenter: ContactsPresenterInput {
    
    weak var output: ContactsPresenterOutput!
    
    // MARK: Presentation logic
 
    func presentLogOut(response: Contacts.Logout.Response){
        
        output.displayLogOut(viewModel: Contacts.Logout.ViewModel())
    }
    
    func presentData(response: Contacts.Fetch.Response){
    
        output.displayData(viewModel: Contacts.Fetch.ViewModel(userData: response.userData))
    }
    
    func presentMessages(response: Contacts.Message.Response){
        
        output.displayMessages(viewModel: Contacts.Message.ViewModel(messageViewModel: response.messageModel))
    }
    
    func presentDeletedMessage(response: Contacts.Delete.Response){
        
        output.displayDeletedMessage(viewModel: Contacts.Delete.ViewModel(rowIndex: response.rowIndex))
    }
}
