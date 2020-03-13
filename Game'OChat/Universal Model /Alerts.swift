//
//  Alerts.swift
//  Game'OChat
//
//  Created by Roushil singla on 3/14/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation
import UIKit


protocol ErrorAlert{
        
    func alertError(message: String)
}

protocol SuccessAlert{
    
    func alertSuccess(message: String)
}
