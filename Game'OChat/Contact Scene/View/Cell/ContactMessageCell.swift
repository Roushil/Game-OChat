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
            K.Reference.database.child("users").child(id).observeSingleEvent(of: .value, with: {  (snapshot) in
                
                guard let dictionary =  snapshot.value as? [String: AnyObject], let name =  dictionary["name"] as? String, let image = dictionary["profileImageURL"] as? String else { return }
                
                self.contactName.text = name
                self.contactProfileImage.loadImageUsingCache(image: image)
                
            }, withCancel: nil)
        }
        
        contactMessage.text = contactDetail.text
        
        guard let seconds = contactDetail.timeStamp?.doubleValue else { return }
        let time = NSDate(timeIntervalSince1970: seconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        messageTime.text = dateFormatter.string(from: time as Date)
    }

}
