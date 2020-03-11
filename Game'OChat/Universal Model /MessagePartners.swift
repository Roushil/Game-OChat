//
//  MessagePartners.swift
//  Game'OChat
//
//  Created by Roushil singla on 3/1/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation
import Firebase

class MessagePartners: NSObject {
    
    func getPartnerID(messageDetail: MessageModel) -> String?{
                
        return messageDetail.fromID == (Auth.auth().currentUser?.uid) ? (messageDetail.toID):(messageDetail.fromID)
    }
    
}

class MessageModel:NSObject{
    
    @objc var fromID: String?
    @objc var text: String?
    @objc var timeStamp: NSNumber?
    @objc var toID: String?
    @objc var imageURL: String?
}


