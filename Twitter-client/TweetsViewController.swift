//
//  TweetsViewController.swift
//  Twitter-client
//
//  Created by Xiomara on 10/30/16.
//  Copyright © 2016 Xiomara. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    static let sharedInstance = TweetsViewController()
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var refreshControl: UIRefreshControl!
    var isMoreDataLoading: Bool = false
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    var originalLeftMargin: CGFloat!
    
    var menuController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuController.view)
        }
    }
    
    var contentController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            contentView.addSubview(contentController.view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.getHomeTimeLine()
        
        refreshControl = UIRefreshControl(frame: CGRect.zero)
        refreshControl.addTarget(self,
            action: #selector(refreshAction),
            for: .allEvents
        )
        
        tableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getHomeTimeLine()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let indexPath = tableView.indexPath(for: cell)!
            let tweet = tweets[indexPath.row]
            
            let detailsViewController = segue.destination as! TweetDetailsViewController
            detailsViewController.tweet = tweet
        }
    }
    
    @IBAction func onSignOutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
        
    }

    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalLeftMargin = leftMarginConstraint.constant
        } else if sender.state == UIGestureRecognizerState.changed {
            leftMarginConstraint.constant = originalLeftMargin + translation
            .x
        } else if sender.state == UIGestureRecognizerState.ended {
            
            UIView.animate(withDuration: 0.3, animations: {
                if velocity.x > 0 {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 50
                } else {
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Selector Methods
    func refreshAction(sender: AnyObject) {
        self.getHomeTimeLine()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: - Helper Methods
    func getHomeTimeLine() {
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            
            }, failure: { (error) in
                print("Error: \(error.localizedDescription)")
        })
    }
}

// MARK: - TableView Methods
extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        let tweet = tweets[indexPath.row]
        cell.tweetText.text = tweet.text
        cell.username.text = tweet.user?.name
        
        if let screenName = tweet.user?.screenName {
            cell.screenName.text = "@\(screenName)"
        }
        
        if let profileURL = tweet.user?.profileURL {
            cell.profileImageView.setImageWith(profileURL as URL)
        }
        
        if let time = tweet.timestamp {
            let formatter = DateFormatter()
            let hours = time.timeIntervalSinceNow
            
            print("hours \(hours)")
            
            //cell.timestamp.text = formatter.string(from: time.timeIntervalSinceNow as Date)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ScrollView Methods
extension TweetsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMoreDataLoading {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                TwitterClient.sharedInstance?.reloadHome(
                tweetID: tweets.last!.id!,
                success: { tweets in
                    for tweet in tweets {
                        self.tweets.append(tweet)
                    }
                    
                    self.isMoreDataLoading = false
                    self.tableView.reloadData()
                    
                }, failure: { error in
                    print(error.localizedDescription)
                })
            }
        }
    }
}





