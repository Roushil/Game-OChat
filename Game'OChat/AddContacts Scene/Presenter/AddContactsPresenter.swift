//
//  AddContactsPresenter.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/15/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol AddContactsPresenterInput {
    func present(response: AddContacts.Fetch.Response)
}

protocol AddContactsPresenterOutput: class {
    func display(viewModel: AddContacts.Fetch.ViewModel)
}

class AddContactsPresenter: AddContactsPresenterInput {
    
    weak var output: AddContactsPresenterOutput!
    
    // MARK: Presentation logic
    
    func present(response: AddContacts.Fetch.Response) {
        
        output.display(viewModel: AddContacts.Fetch.ViewModel(contactViewModel: response.contactDataModel))
        
    }
}
