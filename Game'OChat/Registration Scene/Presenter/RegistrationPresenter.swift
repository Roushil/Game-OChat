//
//  RegistrationPresenter.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol RegistrationPresenterInput {
    func present(response: Registration.Fetch.Response)
}

protocol RegistrationPresenterOutput: class {
    func display(viewModel: Registration.Fetch.ViewModel)
}

class RegistrationPresenter: RegistrationPresenterInput {
    
    weak var output: RegistrationPresenterOutput!
    
    // MARK: Presentation logic
    
    func present(response: Registration.Fetch.Response) {
        
        let viewModel = Registration.Fetch.ViewModel()
        output.display(viewModel: viewModel)
    }
}
