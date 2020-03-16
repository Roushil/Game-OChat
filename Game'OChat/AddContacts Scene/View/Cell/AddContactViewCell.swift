//
//  AddContactViewCell.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/15/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class AddContactViewCell: UITableViewCell {
    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(viewModel: AddContactsModel){
        
        guard let name = viewModel.name, let profile = viewModel.profileImageURL, let email = viewModel.email else { return }
        contactName.text = name
        contactEmail.text = email
        profileImage.loadImageUsingCache(image: profile)
    }
        
}
