//
//  HamburgerViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 11/6/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!

    
    @IBOutlet weak var leftMarginConstraints: NSLayoutConstraint!
    var originalLeftMargin: CGFloat!
    
    var menuController: UIViewController! {
        didSet(oldContentController) {
            view.layoutIfNeeded()
            
            if oldContentController != nil {
                oldContentController.willMove(toParentViewController: nil)
                oldContentController.view.removeFromSuperview()
                
                oldContentController.didMove(toParentViewController: nil)
            }
            
            menuController.willMove(toParentViewController: self)
            menuView.addSubview(menuController.view)
            
            menuController.didMove(toParentViewController: self)
        }
    }
    
    var contentController: UIViewController! {
        didSet(oldContentController) {
            view.layoutIfNeeded()
            
            if oldContentController != nil {
                oldContentController.willMove(toParentViewController: nil)
                oldContentController.view.removeFromSuperview()
                
                oldContentController.didMove(toParentViewController: nil)
            }
                    
            contentController.willMove(toParentViewController: self)
            contentView.addSubview(contentController.view)
            
            contentController.didMove(toParentViewController: self)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.leftMarginConstraints.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalLeftMargin = leftMarginConstraints.constant
        } else if sender.state == UIGestureRecognizerState.changed {
            leftMarginConstraints.constant = originalLeftMargin + translation
                .x
        } else if sender.state == UIGestureRecognizerState.ended {
            
            UIView.animate(withDuration: 0.3, animations: {
                if velocity.x > 0 {
                    self.leftMarginConstraints.constant = self.view.frame.size.width - 100
                } else {
                    self.leftMarginConstraints.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        }
    }
    
}
