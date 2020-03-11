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
                var chatPartner: AddContactsViewModel?
             }
             
             struct ViewModel {
                
                var message: [MessageModel]
                var chatPartner: AddContactsViewModel?
             }
         }
    }
    
    enum NewContact {
        
        struct Request {
            
        }
        
        struct Response {
            
            var contactDetail: AddContactsViewModel
        }
        
        struct ViewModel {
            
            var viewContactDetail: AddContactsViewModel
        }
    }
}
