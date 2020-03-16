//
//  ChatLogDataStore.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/28/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol ChatLogDataStore {
    
    var selectedNewContact: AddContactsModel? { get set}
    
}

class DefaultChatLogDataStore: ChatLogDataStore {
    
    var selectedNewContact: AddContactsModel?
}
