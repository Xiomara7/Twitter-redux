//
//  MentionCellTableViewCell.swift
//  Twitter-client
//
//  Created by Xiomara on 11/7/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class MentionCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweet: UILabel!
    @IBOutlet weak var inReplyTo: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImage.layer.cornerRadius = 5.0
        profileImage.layer.masksToBounds = true
    }

}
