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
        
        static var database: DatabaseReference = Database.database().reference(fromURL:  "https://game-ochat.firebaseio.com/")
        
    }
    
    struct ViewControllers{
        
        static var logIn = "LogInViewController"
        static var registration = "RegistrationViewController"
        static var logInOrRegister = "LogInOrRegisterViewController"
        static var addContact = "AddContactsViewController"
        static var chatLog = "ChatLogViewController"
    }
    
    struct Cell{
        
        static var contactMessage = "ContactMessageCell"
        static var addContact = "AddContactViewCell"
        static var chat = "ChatCell"
    }
    
    static var users = "users"
    static var empty = ""
    static var userMessages = "usrmsgs"
    static var messages = "messages"
    
    static var name = "name"
    static var email = "email"
    static var profileImageURL = "profileImageURL"
    static var text = "text"
    static var imageURL = "imageURL"
    
    static var toId = "toID"
    static var fromId = "fromID"
    static var timeStamp = "timeStamp"
    static var dateFormat = "hh:mm a"
    
    static var alert = "Alert"
    static var okay = "OK"
    static var cancel = "Cancel"
    
    static var registered = "Successfully Registered"
    static var logged = "Successfully Logged In"
    
    static var blankImage = "blank_profile"
}

