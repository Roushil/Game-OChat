//
//  AddContactsWorker.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/15/20.
//  Copyright (c) 2020 personal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Firebase


protocol PassContacts {
    func passData(contacts: [AddContactsModel])
}

class AddContactsWorker:NSObject {
    
    var contacts:[AddContactsModel] = []
    var delegate: PassContacts?
    
    func fetch(currentUser: String) {

        K.Reference.database.child(K.users).observe(.childAdded, with: { [weak self] (snapShot) in
            
            guard let _self = self else { return }
            guard let dictionary = snapShot.value as? [String: AnyObject] else { return }
            let uniqueID = snapShot.ref.key!
            let name = dictionary[K.name] as? String
            let email = dictionary[K.email] as? String
            let profileImage = dictionary[K.profileImageURL] as? String
            _self.contacts.append(AddContactsModel(name: name,
                                                   email: email,
                                                   profileImageURL: profileImage,
                                                   uniqueUserID: uniqueID))
            let contactDetails = _self.contacts.filter({ $0.name != currentUser})
            
            _self.delegate?.passData(contacts: contactDetails)
            }, withCancel: nil)
    }
}
