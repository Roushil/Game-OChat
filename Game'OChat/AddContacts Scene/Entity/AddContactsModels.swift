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
            
            let contactViewModel: [AddContactsViewModel]
        }
    }
}


struct AddContactsModel {
    
    var name: String?
    var email: String?
    var profileImageURL: String?
    var uniqueUserID: String?
}



struct AddContactsViewModel{
    
    var name: String?
    var email: String?
    var profileImage:String?
    var uniqueUserID:String?
    
}

extension AddContactsViewModel{
    
    init(dataModel: AddContactsModel) {
        
        self.name = dataModel.name ?? ""
        self.email = dataModel.email ?? ""
        self.profileImage = dataModel.profileImageURL ?? ""
        self.uniqueUserID = dataModel.uniqueUserID ?? ""
    }
}
