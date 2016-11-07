//
//  MentionsViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 11/6/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController {

    var mentions: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        TwitterClient.sharedInstance?.mentions(success: { tweets in
            self.mentions = tweets
            self.tableView.reloadData()
        }, failure: { error in
            //error handle
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MentionsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mentions != nil {
            return mentions.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mentionCell", for: indexPath) as! MentionCell
        
        let tweet = mentions[indexPath.row]
    
        cell.username.text = tweet.user?.name
        cell.screenName.text = tweet.user?.screenName
        
        cell.tweet.text = tweet.text
        cell.inReplyTo.text = "In reply to Xio"
        
        if let profileURL = tweet.user?.profileURL {
            cell.profileImage.setImageWith(profileURL as URL)
        }
        
        return cell
    }
}
