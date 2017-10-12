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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Register our two custom cells
        self.tableView.register(UINib(nibName: "BPrimaryCell", bundle: nil), forCellReuseIdentifier: "BPrimaryCell")
        self.tableView.register(UINib(nibName: "BSecondaryCell", bundle: nil), forCellReuseIdentifier: "BSecondaryCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 320 : 160;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellString = indexPath.row == 0 ? "BPrimaryCell" : "BSecondaryCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellString)
        
        return cell!
    }
}
