//
//  BNewsItem.swift
//  ABCNews
//
//  Created by Simon Smiley-Andrews on 12/10/2017.
//  Copyright © 2017 Simon Smiley-Andrews. All rights reserved.
//

import UIKit

class BNewsItem: NSObject {

    var thumbnailURL: String? // Link to the smaller version of the URL
    var imageURL: String? // Link to the link URL
    var title: String?
    var date: String?
    
    public func setInfoWithDict(dictionary: NSDictionary) {
        
        self.title = dictionary.object(forKey: "title") as? String
        self.date = self.stringToDate(dateString: dictionary.object(forKey: "pubDate") as! String)
        
        let imageDict = dictionary.object(forKey: "enclosure") as! NSDictionary
        
        self.thumbnailURL = imageDict.object(forKey: "thumbnail") as? String
        self.imageURL = imageDict.object(forKey: "link") as? String
    }
    
    func stringToDate(dateString: String) -> String {
        
        let dateFormatter = DateFormatter()
        
        // This is our current date format
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        
        // Convert to the date format we want
        dateFormatter.dateFormat = "MMM d, yyyy hh:mm a"
        let timeStamp = dateFormatter.string(from: date!)
        
        return timeStamp
    }
}
