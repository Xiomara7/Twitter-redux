//
//  TweetCell.swift
//  Twitter-client
//
//  Created by Xiomara on 10/30/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        profileImageView.layer.cornerRadius = 5.0
        profileImageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        profileImageView.image = nil
    }
}
