//
//  RegistrationModels.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights 

import UIKit

enum Registration {
    
    // MARK:- Use cases
    
    enum Fetch {
        
        struct Request {
            
            var registerData: RegisterData
            var viewcontroller: RegistrationViewController
        }
        
        struct Response {
        }
        
        struct ViewModel {
        }
    }
}

struct RegisterData{
    
    var name: String
    var email: String
    var password: String
    var profileImage: UIImage
}
