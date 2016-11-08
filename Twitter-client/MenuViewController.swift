//
//  MenuViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 11/2/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tweetsController: TweetsViewController!
    var hamburgerController: HamburgerViewController!
    
    var navControllers: [UINavigationController] = []
    var viewControllers: [UIViewController] = []
    
    var menuSections = ["timeline", "profile", "mentions"]
    var cellImages = ["timeline", "me", "love"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tweetsNavController = storyboard.instantiateViewController(withIdentifier: "TweetsNC") as! UINavigationController
        let profileNavController = storyboard.instantiateViewController(withIdentifier: "ProfileNC") as! UINavigationController
        let mentionsNavController = storyboard.instantiateViewController(withIdentifier: "MentionsNC") as! UINavigationController
        
        navControllers.append(tweetsNavController)
        navControllers.append(profileNavController)
        navControllers.append(mentionsNavController)
        
        hamburgerController.contentController = tweetsNavController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return navControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        
        cell.textLabel?.text = menuSections[indexPath.row]
        cell.imageView?.image = UIImage(named: cellImages[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerController.contentController = navControllers[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
