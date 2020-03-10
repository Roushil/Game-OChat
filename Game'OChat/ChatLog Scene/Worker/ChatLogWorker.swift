//
//  ChatLogWorker.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/28/20.
//  Copyright (c) 2020 personal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Firebase

protocol LoadMessage{
    
    func passMessageDetails(message: [MessageModel], userDetail: AddContactsViewModel?)
}


class ChatLogWorker {
    
    
    var delegate: LoadMessage?
    
    func saveMessage(message: String, toUserID: String) {
        
        guard let fromID = Auth.auth().currentUser?.uid else { return }
        let timeStamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        let ref = K.Reference.database.child("messages")
        let childRef = ref.childByAutoId()
        let values = ["text": message, "toID": toUserID, "fromID": fromID, "timeStamp": timeStamp] as [String : Any]
        childRef.updateChildValues(values) { (error, reference) in
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let messageId = childRef.key else { return }
            let userMessagesRef = K.Reference.database.child("usrmsgs").child(fromID).child(toUserID).child(messageId)
            userMessagesRef.setValue(1 as AnyObject)
            
            let recepientMessageRef = K.Reference.database.child("usrmsgs").child(toUserID).child(fromID).child(messageId)
            recepientMessageRef.setValue(1 as AnyObject)
        }
    }
    
    
    func loadMessages(userDetail: AddContactsViewModel?){
        
        var messages: [MessageModel] = []
 
        guard let currentUserId = Auth.auth().currentUser?.uid, let partnerId = userDetail?.uniqueUserID else { return }
        K.Reference.database.child("usrmsgs").child(currentUserId).child(partnerId).observe(.childAdded, with: { (snapShot) in
            
            let messageId = snapShot.key
            K.Reference.database.child("messages").child(messageId).observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                let message = MessageModel()
                message.setValuesForKeys(dictionary)
                
                messages.append(message)
                self.delegate?.passMessageDetails(message: messages, userDetail: userDetail)
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
}
