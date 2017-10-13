//
//  BMainViewController.swift
//  ABCNews
//
//  Created by Simon Smiley-Andrews on 12/10/2017.
//  Copyright © 2017 Simon Smiley-Andrews. All rights reserved.
//

import UIKit

class BMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var newsItems = [BNewsItem]()
    let searchURL = URL(string: "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml")
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Register our two custom cells
        self.tableView.register(UINib(nibName: "BPrimaryCell", bundle: nil), forCellReuseIdentifier: "BPrimaryCell")
        self.tableView.register(UINib(nibName: "BSecondaryCell", bundle: nil), forCellReuseIdentifier: "BSecondaryCell")

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshNewsStories), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        self.configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Refresh when app comes into the foreground
        self.refreshNewsStories()
    }
    
    func configureNavigationBar() {
        
        let imageView = UIImageView(image: UIImage(named: "icn_b2cloud.png"))
        imageView.frame.size = CGSize(width: 80, height: 22)
        
        self.navigationController?.navigationBar.addSubview(imageView)
        
        imageView.frame = CGRect(x: (UIScreen.main.bounds.size.width - imageView.frame.size.width)/2, y: 10, width: imageView.frame.size.width, height: imageView.frame.size.height)
    }
    
    @objc func refreshNewsStories() {
        
        BAPIManager.sharedInstance.getJsonFromURL(url: searchURL!) { (news) in
            self.newsItems = news as! [BNewsItem]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 360 : 120;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BPrimaryCell") as! BPrimaryCell
            cell.configureWithNews(newsItem: newsItems[indexPath.row])
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BSecondaryCell") as! BSecondaryCell
            cell.configureWithNews(newsItem: newsItems[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
