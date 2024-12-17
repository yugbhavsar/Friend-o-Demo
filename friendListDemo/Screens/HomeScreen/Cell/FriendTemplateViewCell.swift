//
//  FriendTemplateViewCell.swift
//  friendListDemo
//
//  Created by Techify on 18/12/24.
//

import UIKit

class FriendTemplateViewCell: UITableViewCell {

    @IBOutlet weak var addToFavBtn: UIButton!
    @IBOutlet weak var lbeFriendEmail: UILabel!
    @IBOutlet weak var lbeFriendName: UILabel!
    
    var addFavCompletion: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToFavBtnAction(_ sender: Any) {
        self.addFavCompletion?()
    }
}
