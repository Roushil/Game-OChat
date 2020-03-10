//
//  Constants.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/10/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation
import Firebase


struct K{
    
    struct Reference{
        
        static var database: DatabaseReference = Database.database().reference(fromURL: "https://game-ochat.firebaseio.com/")
        
    }
    
    static var users = "users"
    
}

