//
//  ContactsDataStore.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol ContactsDataStore {
    
    var selectedNewContact: AddContactsModel? { get set }
    var currentUserName: String? { get set }
}

class DefaultContactsDataStore: ContactsDataStore {
    
    var selectedNewContact: AddContactsModel?
    var currentUserName: String?
}
