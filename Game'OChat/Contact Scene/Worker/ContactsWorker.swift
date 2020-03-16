//
//  ContactsWorker.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Firebase

protocol HandleLogout {
    
    func checkLog(isLogout:Bool, userData: [String: AnyObject?])
}

protocol Messages{
    
    func passMessage(messageModel: [MessageModel])
}

protocol ContactDelete{
    
    func deleteContact(rowIndex: Int)
}


class ContactsWorker {
    
    var logDelegate: HandleLogout?
    var messageDelegate: Messages?
    var deleteMessageDelegate: ContactDelete?
    var alertDelegate: ErrorAlert?
    var messages: [MessageModel] = []
    let messagePartner = MessagePartners()
    var messageDictionary = [String: MessageModel]()
    
    
    func checkLogout() {
        
        if Auth.auth().currentUser?.uid == nil{
            
            do{
                try Auth.auth().signOut()
                logDelegate?.checkLog(isLogout: true, userData: [K.empty: nil])
            }
            catch let error{
                
                alertDelegate?.alertError(message: error.localizedDescription)
            }
        }
        else{
            
            let userId = Auth.auth().currentUser?.uid
            K.Reference.database.child(K.users).child(userId!).observeSingleEvent(of: .value, with: { (snapShot) in
                
                guard let dictionary = snapShot.value as? [String: AnyObject] else { return }
                self.logDelegate?.checkLog(isLogout: false, userData: dictionary)
            }, withCancel: nil)
        }
    }
    
    func logOut(){
        
        do{
            try Auth.auth().signOut()
            logDelegate?.checkLog(isLogout: true, userData: [K.empty: nil])
        }
        catch let error{
            
            alertDelegate?.alertError(message: error.localizedDescription)
        }
    }
    
    
    func loadUserMessages(){
        
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        K.Reference.database.child(K.userMessages).child(currentUserId).observe(.childAdded, with: { (snapShot) in
            
            let userID = snapShot.key
            K.Reference.database.child(K.userMessages).child(currentUserId).child(userID).observe(.childAdded, with: { (snapShot) in
                
                let messageId = snapShot.key
                K.Reference.database.child(K.messages).child(messageId).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                    
                    let message = MessageModel(dictionary: dictionary)
            
                    guard let chatPartnerID = self.messagePartner.getPartnerID(messageDetail: message) else {return}
                    
                    self.messageDictionary[chatPartnerID] = message
                    self.messages = Array(self.messageDictionary.values)
                    
                    self.messages.sort(by: { (message1, message2) -> Bool in

                        return message1.timeStamp!.int32Value > message2.timeStamp!.int32Value
                    })

                    self.messageDelegate?.passMessage(messageModel: self.messages)
                    
                }, withCancel: nil)
                
            }, withCancel: nil)
            
        }, withCancel: nil)
        
    }
    
    
    func deleteUserMessages(rowIndex: Int){
        
        let message = self.messages[rowIndex]
        guard let currentUserId = Auth.auth().currentUser?.uid, let chatPartnerID = self.messagePartner.getPartnerID(messageDetail: message) else { return }
        
        K.Reference.database.child(K.userMessages).child(currentUserId).child(chatPartnerID).removeValue { (error, reference) in
            
            if let err = error{
                self.alertDelegate?.alertError(message: err.localizedDescription)
            }
            
            self.messageDictionary.removeValue(forKey: chatPartnerID)
            self.deleteMessageDelegate?.deleteContact(rowIndex: rowIndex)
        }
    }
}

