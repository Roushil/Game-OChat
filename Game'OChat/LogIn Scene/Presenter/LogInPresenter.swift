//
//  LogInPresenter.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol LogInPresenterInput {
    func present(response: LogIn.Fetch.Response)
}

protocol LogInPresenterOutput: class {
    func display(viewModel: LogIn.Fetch.ViewModel)
}

class LogInPresenter: LogInPresenterInput {
    
    weak var output: LogInPresenterOutput!
    
    // MARK: Presentation logic
    
    func present(response: LogIn.Fetch.Response) {
        
        let viewModel = LogIn.Fetch.ViewModel()
        output.display(viewModel: viewModel)
    }
}
