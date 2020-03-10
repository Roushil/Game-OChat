//
//  RegistrationDataStore.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.

import UIKit

protocol RegistrationDataStore {
    var profileImage: UIImage? { get set }
    
}

class DefaultRegistrationDataStore: RegistrationDataStore {
    var profileImage: UIImage?
}
