//
//  ContactMessageCell.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/29/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit
import Firebase

class ContactMessageCell: UITableViewCell {

    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactMessage: UILabel!
    @IBOutlet weak var contactProfileImage: UIImageView!
    @IBOutlet weak var messageTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(contactDetail: MessageModel){
        
        let msgPartner = MessagePartners()
        
        if let id = msgPartner.getPartnerID(messageDetail: contactDetail)  {
            K.Reference.database.child(K.users).child(id).observeSingleEvent(of: .value, with: { [weak self]  (snapshot) in
                
                guard let _self = self else { return }
                guard let dictionary =  snapshot.value as? [String: AnyObject], let name =  dictionary[K.name] as? String, let image = dictionary[K.profileImageURL] as? String else { return }
                
                _self.contactName.text = name
                _self.contactProfileImage.loadImageUsingCache(image: image)
                
            }, withCancel: nil)
        }
        
        contactMessage.text = contactDetail.text
        
        guard let seconds = contactDetail.timeStamp?.doubleValue else { return }
        let time = NSDate(timeIntervalSince1970: seconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = K.dateFormat
        messageTime.text = dateFormatter.string(from: time as Date)
    }

}
