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
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        profileImageView.backgroundColor = UIColor.gray
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5.0
        
        TwitterClient.sharedInstance?.currentAccount(success: { user in
            self.currentUser = user
            self.profileImageView.setImageWith(self.currentUser.profileURL as! URL)
        }, failure: { error in
            //error
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
