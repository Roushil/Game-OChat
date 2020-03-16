//
//  ChatLogModels.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/28/20.
//  Copyright (c) 2020 personal. All rights 

import UIKit

enum ChatLog {
    
    enum Message {
        
        enum SaveText{
            
            struct Request {
                
                var messgae: String
            }
            
            struct Response {
                
            }
            
            struct ViewModel {
                
            }
        }
        
        enum SaveImage{
            
            struct Request {
                
                var image: UIImage
            }
            
            struct Response {
                
            }
            
            struct ViewModel {
                
            }
        }

        enum Load{
             
             struct Request {
                 
             }
             
             struct Response {
                
                var message: [MessageModel]
                var chatPartner: AddContactsModel?
             }
             
             struct ViewModel {
                
                var message: [MessageModel]
                var chatPartner: AddContactsModel?
             }
         }

    }
    
    enum NewContact {
        
        struct Request {
            
        }
        
        struct Response {
            
            var contactDetail: AddContactsModel
        }
        
        struct ViewModel {
            
            var viewContactDetail: AddContactsModel
        }
    }
    
    enum AlertMessage {
        
        struct Request {
        }
        
        struct Response {
            var message: String
        }
        
        struct ViewModel {
            var message: String
        }
    }
}
