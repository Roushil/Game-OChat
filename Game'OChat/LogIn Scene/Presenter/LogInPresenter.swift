//
//  LogInPresenter.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol LogInPresenterInput {
    func presentErrorAlert(response: LogIn.AlertMessage.Error.Response)
    func presentSuccessAlert(response: LogIn.AlertMessage.Success.Response)
}

protocol LogInPresenterOutput: class {
    func displayErrorAlert(viewModel: LogIn.AlertMessage.Error.ViewModel)
    func displaySuccessAlert(viewModel: LogIn.AlertMessage.Success.ViewModel)
}

class LogInPresenter: LogInPresenterInput {
    
    weak var output: LogInPresenterOutput!
    
    // MARK: Presentation logic
    
    func presentErrorAlert(response: LogIn.AlertMessage.Error.Response){
        
        output.displayErrorAlert(viewModel: LogIn.AlertMessage.Error.ViewModel(message: response.message))
    }
    
    func presentSuccessAlert(response: LogIn.AlertMessage.Success.Response){
        
        output.displaySuccessAlert(viewModel: LogIn.AlertMessage.Success.ViewModel(message: response.message))
    }
}
