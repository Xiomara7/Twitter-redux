//
//  LoginViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 10/28/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.login(success: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initController = storyboard.instantiateInitialViewController() as! HamburgerViewController
            let menuNavController = storyboard.instantiateViewController(withIdentifier: "MenuNC") as! UINavigationController
            let menuController = menuNavController.topViewController as! MenuViewController
            
            menuController.hamburgerController = initController
            initController.menuController = menuNavController
            
            self.present(initController, animated: true, completion: nil)
            
        }, failure: { (error) in
            print("Error \(error.localizedDescription)")
        })
    }
}
