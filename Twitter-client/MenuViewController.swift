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
    var navControllers: [UINavigationController] = []
    var viewControllers: [UIViewController] = []
    var menuSections = ["timeline", "profile", "mentions"]
    
    var hamburgerController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tweetsNavController = storyboard.instantiateViewController(withIdentifier: "TweetsNC") as! UINavigationController
        let profileNavController = storyboard.instantiateViewController(withIdentifier: "ProfileNC") as! UINavigationController
        let mentionsNavController = storyboard.instantiateViewController(withIdentifier: "MentionsNC") as! UINavigationController
        
        let tweetsController = storyboard.instantiateViewController(withIdentifier: "TweetsController") as! TweetsViewController
        let profileController = storyboard.instantiateViewController(withIdentifier: "ProfileController") as! ProfileViewController
        let mentionsController = storyboard.instantiateViewController(withIdentifier: "MentionsController") as! MentionsViewController
        
        navControllers.append(tweetsNavController)
        navControllers.append(profileNavController)
        navControllers.append(mentionsNavController)
        
        viewControllers.append(tweetsController)
        viewControllers.append(profileController)
        viewControllers.append(mentionsController)
        
        hamburgerController.contentController = tweetsNavController
        //hamburgerController.contentView = tweetsNavController.view
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerController.contentController = navControllers[indexPath.row]
        //hamburgerController.contentView = viewControllers[indexPath.row].view
    }
}
