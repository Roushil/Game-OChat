//
//  RegistrationPresenter.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol RegistrationPresenterInput {
    func presentAlertError(response: Registration.AlertMessage.Error.Response)
    func presentAlertSuccess(response: Registration.AlertMessage.Success.Response)
}

protocol RegistrationPresenterOutput: class {
    func displayAlertError(viewModel: Registration.AlertMessage.Error.ViewModel)
    func displayAlertSuccess(viewModel: Registration.AlertMessage.Success.ViewModel)
}

class RegistrationPresenter: RegistrationPresenterInput {
    
    weak var output: RegistrationPresenterOutput!
    
    // MARK: Presentation logic
    
    
    func presentAlertError(response: Registration.AlertMessage.Error.Response){
        
        output.displayAlertError(viewModel: Registration.AlertMessage.Error.ViewModel(message: response.message))
    }
    
    func presentAlertSuccess(response: Registration.AlertMessage.Success.Response){
        
        output.displayAlertSuccess(viewModel: Registration.AlertMessage.Success.ViewModel(message: response.message))
    }
}
