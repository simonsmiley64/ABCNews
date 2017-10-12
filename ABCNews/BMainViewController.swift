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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Register our two custom cells
        self.tableView.register(UINib(nibName: "BPrimaryCell", bundle: nil), forCellReuseIdentifier: "BPrimaryCell")
        self.tableView.register(UINib(nibName: "BSecondaryCell", bundle: nil), forCellReuseIdentifier: "BSecondaryCell")
        
        self.refreshNewsStories()
    }

    func refreshNewsStories() {
        
        BAPIManager.sharedInstance.getJsonFromURL(url: searchURL!) { (news) in
            self.newsItems = news as! [BNewsItem]
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 320 : 160;
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
}
