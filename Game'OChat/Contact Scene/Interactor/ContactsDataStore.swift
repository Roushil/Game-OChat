//
//  ContactsDataStore.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol ContactsDataStore {
    
    var selectedNewContact: AddContactsViewModel? { get set}
}

class DefaultContactsDataStore: ContactsDataStore {
    
    var selectedNewContact: AddContactsViewModel?
}
