//
//  BAPIManager.swift
//  ABCNews
//
//  Created by Simon Smiley-Andrews on 12/10/2017.
//  Copyright © 2017 Simon Smiley-Andrews. All rights reserved.
//

import UIKit
import Alamofire

class BAPIManager: NSObject {

    class var sharedInstance: BAPIManager {
        struct singleton {
            static let instance = BAPIManager()
        }
        return singleton.instance
    }
    
    public func getJsonFromURL(url: URL, completionHandler: @escaping (NSArray) -> ()) {
        
        Alamofire.request(url).responseJSON { response in
            let json = response.result.value as! NSDictionary
            
            completionHandler(self.convertJsonToNewsObjects(jsonDict: json))
        }
    }
    
    func convertJsonToNewsObjects(jsonDict: NSDictionary) -> NSArray {
        
        let feed = jsonDict.value(forKey: "items") as! NSArray
        let newsItems = NSMutableArray()
        
        for dict in feed {
            let news = BNewsItem()
            news.setInfoWithDict(dictionary: dict as! NSDictionary)
            newsItems.add(news)
        }
        
        return NSArray(array: newsItems)
    }
}
