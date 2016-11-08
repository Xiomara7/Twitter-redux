//
//  ProfileViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 11/6/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var friendsCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5.0
        
        if currentUser == nil {
            if User.currentUser != nil {
                currentUser = User.currentUser!
                self.setProfileInfo()
            }
        } else {
            self.setProfileInfo()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setProfileInfo() {
        profileImageView.setImageWith(currentUser.profileURL as! URL)
        headerImageView.setImageWith(currentUser.headerURL as! URL)
        
        username.text = currentUser.name
        tagLineLabel.text = currentUser.tagLine
        
        if let screenname = currentUser.screenName {
            screenName.text = "@\(screenname)"
        }
        if let followers = currentUser.followers {
            followersCount.text = "\(followers)"
        }
        if let friends = currentUser.friends {
            friendsCount.text = "\(friends)"
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        
        cell.textLabel?.text = "Hola"
        
        return cell
    }
}
