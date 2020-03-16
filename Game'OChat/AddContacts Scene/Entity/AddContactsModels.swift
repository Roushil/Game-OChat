//
//  AddContactsModels.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/15/20.
//  Copyright (c) 2020 personal. All rights 

import UIKit

enum AddContacts {
    
    // MARK:- Use cases
    
    enum Fetch {
        
        struct Request {
        }
        
        struct Response {
            
            let contactDataModel: [AddContactsModel]
        }
        
        struct ViewModel {
            
            let contactViewModel: [AddContactsModel]
        }
    }
}


struct AddContactsModel {
    
    var name: String?
    var email: String?
    var profileImageURL: String?
    var uniqueUserID: String?
}


