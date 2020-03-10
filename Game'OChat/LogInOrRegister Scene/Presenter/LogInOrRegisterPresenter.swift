//
//  LogInOrRegisterPresenter.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol LogInOrRegisterPresenterInput {
    func present(response: LogInOrRegister.Fetch.Response)

}

protocol LogInOrRegisterPresenterOutput: class {
    func display(viewModel: LogInOrRegister.Fetch.ViewModel)

}

class LogInOrRegisterPresenter: LogInOrRegisterPresenterInput {
    
    weak var output: LogInOrRegisterPresenterOutput!
    
    // MARK: Presentation logic
    
    func present(response: LogInOrRegister.Fetch.Response) {
        
        let viewModel = LogInOrRegister.Fetch.ViewModel()
        output.display(viewModel: viewModel)
    }
    

}
