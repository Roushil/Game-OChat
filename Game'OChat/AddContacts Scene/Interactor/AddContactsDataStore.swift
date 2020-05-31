//
//  AddContactsDataStore.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/15/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol AddContactsDataStore {
    var currentUser: String? { get set }
}

class DefaultAddContactsDataStore: AddContactsDataStore {
    
    var currentUser: String?
}
