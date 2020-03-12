//
//  ContactsModels.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights 

import UIKit

enum Contacts {
        
    enum Check {
        
        struct Request {
        }
        
        struct Response {
        }
        
        struct ViewModel {
        }
    }
    
    enum Logout{
        
        struct Request {
        }
           
        struct Response {
        }
           
        struct ViewModel {
        }
    }
    
    enum Fetch {
        
        struct Request {
        }
        
        struct Response {
            
            var userData: [String: AnyObject?]
        }
        
        struct ViewModel {
            
            var userData: [String: AnyObject?]
        }
    }
    
    enum Message {
          
          struct Request {
          }
          
          struct Response {
            
            var messageModel: [MessageModel]
          }
          
          struct ViewModel {
            
            var messageViewModel: [MessageModel]
          }
      }
    
    enum Delete {
        
        struct Request {
            var rowIndex: Int
        }
        
        struct Response {
            var rowIndex: Int
        }
        
        struct ViewModel {
            var rowIndex: Int
        }
    }
}


