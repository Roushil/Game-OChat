//
//  LogInModels.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights 

import UIKit

enum LogIn {
    
    // MARK:- Use cases
    
    enum Fetch {
        
        struct Request {
            
            var userData: LoginData
            var viewController: LogInViewController
        }
        
        struct Response {
        }
        
        struct ViewModel {
        }
    }
    
    enum AlertMessage {
        
        
        enum Error {
            
            struct Request {
            }
            
            struct Response {
                
                var message: String
            }
            
            struct ViewModel {
                var message: String
            }
        }
        
        enum Success {
            
            struct Request {
            }
            
            struct Response {
                
                var message: String
            }
            
            struct ViewModel {
                var message: String
            }
        }
    }}

struct LoginData{
    
    var email: String
    var password: String
}
